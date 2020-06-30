//
//  QuizCollection.swift
//  QuizApp
//
//  Created by Kreso Lelas on 11/05/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import Foundation

class QuizCollection {
    
    let allQuizzes: [Quiz]
    struct Kvizovi : Codable {
        let quizzes: [Quiz]
    }
    
    init?(jsonData: Data) {

        let decoder = JSONDecoder()
        let kvizovi = try? decoder.decode(Kvizovi.self, from: jsonData)
        if kvizovi == nil {
            //saljemo nil da prikaze error view
            return nil
        }
        self.allQuizzes = kvizovi?.quizzes as! [Quiz]
        
    }
    
    func getQuiz(number:Int) -> Quiz{        
        return allQuizzes[number]
    }
}
