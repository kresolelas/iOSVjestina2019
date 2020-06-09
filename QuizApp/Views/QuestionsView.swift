//
//  QuestionsView.swift
//  QuizApp
//
//  Created by sara on 11/05/2020.
//  Copyright © 2020 sara. All rights reserved.
//
import UIKit


class QuestionsView: UIView{
    
    var correctAnswer: Int?
    
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var questionTextBox: UILabel!
    @IBAction func btn3Pressed(_ sender: Any) {
        btnPressed(num:3, sender: sender as! UIView)
    }
    
    @IBAction func btn2Pressed(_ sender: Any) {
         btnPressed(num:2, sender: sender as! UIView)
    }
    @IBAction func btn1Pressed(_ sender: Any) {
         btnPressed(num:1, sender: sender as! UIView)
    }
    @IBAction func btn0Pressed(_ sender: Any) {
         btnPressed(num:0, sender: sender as! UIView)
    }
    @IBOutlet var rootView: UIView!
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    
    }
    
    required init?(coder aDecoder: NSCoder ){
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("QuestionsView", owner:self, options:nil)
        addSubview(rootView)
        rootView.frame = self.bounds
        rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    }
    
    func showQuestionAndAnswers(quiz : Quiz , odabrano: Int){
        
        if quiz.category == "SPORTS" {
            rootView.backgroundColor = UIColor(hue: 0.7278, saturation: 0.2, brightness: 0.94, alpha: 1.0)
        } else {
            rootView.backgroundColor = UIColor(hue: 0.9472, saturation: 0.2, brightness: 0.94, alpha: 1.0)
        }
        let question = quiz.questions[odabrano]
        questionTextBox.text = question.question
        
        correctAnswer = question.correctAnswer
        
        btn0.setTitle(question.answers[0], for: .normal)
        btn1.setTitle(question.answers[1], for: .normal)
        btn2.setTitle(question.answers[2], for: .normal)
        btn3.setTitle(question.answers[3], for: .normal)
        
        btn0.layer.cornerRadius = 20
        btn1.layer.cornerRadius = 20
        btn2.layer.cornerRadius = 20
        btn3.layer.cornerRadius = 20
            
    }
    
    
    func btnPressed(num: Int, sender: UIView){
        if num == correctAnswer {
            //tocanodovor kliknut
            NotificationCenter.default.post(name: Notification.Name("answered"), object: nil,userInfo: ["correct": true])
            rootView.backgroundColor = UIColor.green
        } else {
             NotificationCenter.default.post(name: Notification.Name("answered"), object: nil,userInfo: ["correct": false])
            rootView.backgroundColor = UIColor.red
        }
        
    }
}
