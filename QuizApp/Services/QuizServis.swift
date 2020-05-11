//
//  QuizServis.swift
//  QuizApp
//
//  Created by sara on 11/05/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import Foundation

class QuizServis {
    
    func fetch(urlString: String, completion: @escaping ((QuizCollection?) -> Void)) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue("225b3ddf80msha350534f81c8c4cp1c0858jsn2a5d1107aad8", forHTTPHeaderField: "X-RapidAPI-Key")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let quizCollection = QuizCollection(jsonData: data)
                        completion(quizCollection)
                    } catch {
                        completion(nil)
                    }

                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }

    }
}
