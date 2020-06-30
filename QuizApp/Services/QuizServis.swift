//
//  QuizServis.swift
//  QuizApp
//
//  Created by Kreso Lelas on 11/05/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import Foundation

class QuizServis {
    func getLeaderBoards2(quizId:Int) {
        print("zatrazili smo")
        let token = UserDefaults.standard.object(forKey: "user_token")
        if let url = URL(string:"https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizId)") {
            print("zatrazili smo sa urla ","https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizId)", " s tokenom ", token)
            var request = URLRequest(url: url)
            request.httpMethod="GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("\(token)", forHTTPHeaderField: "Authorization")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let data2 = data {
                    var json:[String: Any]=[:]
                    do{
                        json = try (JSONSerialization.jsonObject(with: data2, options: []) as? [String : Any])!
                    }catch{
                        print("fejl")
                    }
                   
                    do {
                        print(json)
                    }

                } else {
                    
                }
            }
            dataTask.resume()
        } else {
           
        }

    }
    
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
