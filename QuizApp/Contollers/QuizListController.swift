//
//  QuizListController.swift
//  QuizApp
//
//  Created by sara on 08/06/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import UIKit

class QuizListController: UIViewController {
    
   
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
                for quiz in quizCollection!.allQuizzes{
                    self.quizzes.append(quiz)
                     self.addQuizToList(quiz: quiz)
                }
               
            }

           }
        }
        
    }

    func addQuizToList(quiz: Quiz){
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
    
    
}
