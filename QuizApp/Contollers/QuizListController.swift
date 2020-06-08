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
        quizView.showQuizData(quiz: quiz)
    }
    
    
}
