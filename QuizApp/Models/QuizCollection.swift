//
//  QuizCollection.swift
//  QuizApp
//
//  Created by sara on 11/05/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import Foundation

class QuizCollection {
    
    let allQuizzes: [Quiz]
    struct Sara : Codable {
        let quizzes: [Quiz]
    }
    
    init?(jsonData: Data) {

        let decoder = JSONDecoder()
        let sara = try? decoder.decode(Sara.self, from: jsonData)
        if sara == nil {
            //saljemo nil da prikaze error view
            return nil
        }
        self.allQuizzes = sara?.quizzes as! [Quiz]
        
    }
    
    func getQuiz(number:Int) -> Quiz{        
        return allQuizzes[number]
    }
}
