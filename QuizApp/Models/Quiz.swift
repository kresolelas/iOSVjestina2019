//
//  Quiz.swift
//  QuizApp
//
//  Created by sara on 11/05/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import Foundation

class Quiz: Codable {
    let id: Int
    let title, quizDescription, category: String
    let level: Int
    let image: String
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case id, title
        case quizDescription = "description"
        case category, level, image, questions
    }
}
