//
//  Question.swift
//  QuizApp
//
//  Created by kreso on 11/05/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import Foundation

class Question : Codable{
    var id: Int
           var question: String
           var answers: [String]
           var correctAnswer: Int

           enum CodingKeys: String, CodingKey {
               case id, question, answers
               case correctAnswer = "correct_answer"
           }
    init(id : Int, answers:[String],question:String, correct: Int) {
        self.id = id
        self.question = question
        self.answers = answers
        self.correctAnswer = correct
    }
}
