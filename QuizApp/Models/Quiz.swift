//
//  Quiz.swift
//  QuizApp
//
//  Created by Kreso Lelas on 11/05/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import Foundation

class Quiz: Codable {
    var id: Int
    var title, quizDescription, category: String
    var level: Int
    var image: String
    var questions: [Question]

    enum CodingKeys: String, CodingKey {
        case id, title
        case quizDescription = "description"
        case category, level, image, questions
    }
    init(id : Int, title: String, qD: String, c: String, level: Int, image:String, questions:[Question]) {
        self.id = id
        self.title = title
        self.quizDescription = qD
        self.category = c
        self.level = level
        self.image = image
        self.questions = questions
    }
}
