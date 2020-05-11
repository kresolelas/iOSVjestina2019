//
//  ViewController.swift
//  QuizApp
//
//  Created by sara on 11/05/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var funFactText: UILabel!
    @IBOutlet weak var errorView: UILabel!
    @IBAction func dohvatiKlik(_ sender: Any) {
        getQuizzes()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func getQuizzes(){
        let url = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizServis = QuizServis()
        
        quizServis.fetch(urlString: url){ (quizCollection) in
           DispatchQueue.main.async {
                print(quizCollection?.allQuizzes)
            if quizCollection==nil {
                self.errorView.isHidden = false
            }else{
                self.showData(data: quizCollection!.allQuizzes)
            }

           }
        }
        
    }

    func showData(data:[Quiz]){
        
        var numOfNba = 0
        for quiz in data {
            for question in quiz.questions{
                if question.question.contains("NBA"){
                    numOfNba+=1
                }
            }
        }
        
        funFactText.text = String(numOfNba)
        
        let questionsView = QuestionsView(frame: CGRect(x:0,y:250,width:375, height: 600))
        
        let randKviz = Int.random(in: 0..<data.count)
    
        questionsView.showQuestionAndAnswers(quiz:data[randKviz])
        self.view.addSubview(questionsView)
        
       let url = URL(string: data[randKviz].image)
       
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.bgImage.image = UIImage(data: data!)
            }
        }
        
    }
    
    
}
