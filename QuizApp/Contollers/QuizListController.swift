//
//  QuizListController.swift
//  QuizApp
//
//  Created by Kreso Lelas on 08/06/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import UIKit
import CoreData

class QuizListController: UIViewController {
    
    var quizzesDataModels: [NSManagedObject] = []
    var quizzes: [Quiz] = []
    @IBOutlet weak var stackView: UIStackView!
    var segueDest:ViewController?
    var chosenQuiz:Quiz?
    
    override func viewDidLoad() {
        getQuizzes()
       super.viewDidLoad()
       }
    
    func getQuizzes(){
        let url = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizServis = QuizServis()
        
        quizServis.fetch(urlString: url){ (quizCollection) in
           DispatchQueue.main.async {
               // print(quizCollection?.allQuizzes)
            if quizCollection==nil {
                //self.errorView.isHidden = false
            }else{
                // self.showData(data: quizCollection!.allQuizzes)
                //dobili smo kvizove
                self.deleteAllData("QuizModel")
                for quiz in quizCollection!.allQuizzes{
                    self.quizzes.append(quiz)
                     self.addQuizToList(quiz: quiz)
                }
               
            }

           }
        }
        
    }

    func addQuizToList(quiz: Quiz){
        saveQuizzesData(quiz: quiz)
        print("lala", quiz.title)
        let quizView = ListItemView(frame: CGRect(x:0, y:0, width:100, height:100))
        stackView.addArrangedSubview(quizView)
        quizView.tag=quiz.id
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(quizClicked))
        quizView.addGestureRecognizer(gesture)
        quizView.showQuizData(quiz: quiz)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "toMain") {
            print("segue preparean")
            let sDest = segue.destination as? ViewController
            sDest!.chosenQuiz = chosenQuiz
           }
       }
    @objc func quizClicked(sender: UITapGestureRecognizer){
        print("kviz kliknut")
        let view = sender.view!
        let testId = view.tag
        for quiz in quizzes {
            if quiz.id == testId{
                chosenQuiz = quiz
                print("kliknli na kviz", quiz.title)
                //to je odabrani kviz salji te podatke i id dalje
                
                performSegue(withIdentifier: "toMain", sender: nil)
            }
        }
    }
    
    func saveQuizzesData(quiz: Quiz) {
        
        if someEntityExists(id: Int32(quiz.id) , entityName: "QuizModel", type: "Integer", fieldName: "id") {
             print("Data is already present")
              return
         }
        
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "QuizModel",
                                   in: managedContext)!
   
      let kviz = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
        kviz.setValue(quiz.id, forKeyPath: "id")
        kviz.setValue(quiz.title, forKey: "title")
        kviz.setValue(quiz.category, forKey: "category")
        kviz.setValue(quiz.image, forKey: "image")
        kviz.setValue(quiz.level, forKey: "level")
        kviz.setValue(quiz.quizDescription, forKey: "quizDescription")
        var arrayZaUbacit:[NSManagedObject] = []
       for pitanje in quiz.questions{
        let entity2 =
                      NSEntityDescription.entity(forEntityName: "QuestionModel",
                                                 in: managedContext)!
        let pit = NSManagedObject(entity: entity2,
        insertInto: managedContext)
        pit.setValue(kviz, forKey: "parentQuiz")
        pit.setValue(pitanje.question, forKey: "questionTxt")
        pit.setValue(pitanje.correctAnswer, forKey: "correctAnswer")
        // Array of Strings
        let array: [String] = pitanje.answers
        let arrayAsString: String = array.description
        pit.setValue(arrayAsString, forKey: "answersJSON")
        print("setali smo value za answersJSON = ", arrayAsString)
        arrayZaUbacit.append(pit)
       }
        //kviz.(NSSet.init(object: arrayZaUbacit), forKey: "questions")
        
      // 4
      do {
        try managedContext.save()
        print("sejvali smo u CoreData")
        //people.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func someEntityExists(id: Int32, entityName: String, type : String, fieldName : String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if type == "String"{
        fetchRequest.predicate = NSPredicate(format: "\(fieldName) == %@", id)
        }else{
            fetchRequest.predicate = NSPredicate(format: "\(fieldName) == %d", id)

        }

        var results: [NSManagedObject] = []
        guard let appDelegate =
               UIApplication.shared.delegate as? AppDelegate else {
                 return false
             }
        let managedContext =
              appDelegate.persistentContainer.viewContext
        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return results.count > 0
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "QuizModel")
      
      //3
      do {
        quizzesDataModels = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }

    func deleteAllData(_ entity:String) {
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
               managedContext.delete(objectData)
                print("deleted data")
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
