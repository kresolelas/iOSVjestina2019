//
//  Question.swift
//  QuizApp
//
//  Created by sara on 11/05/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import Foundation

class Question : Codable{
    let id: Int
           let question: String
           let answers: [String]
           let correctAnswer: Int

           enum CodingKeys: String, CodingKey {
               case id, question, answers
               case correctAnswer = "correct_answer"
           }
}
