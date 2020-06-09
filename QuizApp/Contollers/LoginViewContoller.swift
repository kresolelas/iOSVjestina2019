//
//  LoginViewContoller.swift
//  QuizApp
//
//  Created by sara on 06/06/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import UIKit

struct UserData: Decodable {
    let user_id: Int
    let user_token: String
    enum CodingKeys: String, CodingKey {
        case user_id="user_id"
        case user_token="token"
    }
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBAction func loginClicked(_ sender: Any) {
        
     //  let vc = ViewController(nibName: "ViewController", bundle: nil)
      //  navigationController?.pushViewController(vc, animated: true)
       login()
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "user_id") != nil && UserDefaults.standard.object(forKey: "user_token") != nil{
            performSegue(withIdentifier: "prijelazNaListu", sender: nil)
        }
    
    }

    func login(){
        
           let username = String(usernameField.text ?? "")
           let password = String(passwordField.text ?? "")
           let parameters = ["username": username, "password": password]
    
        
           let url = URL(string: "https://iosquiz.herokuapp.com/api/session")!
           let session = URLSession.shared
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
    
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
           } catch let error {
               print(error.localizedDescription)
           }
    
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/json", forHTTPHeaderField: "Accept")
  
           let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
    
               guard error == nil else {
                   return
               }
    
               guard let data = data else {
                   return
               }
        
                       do {
                           let userData = try JSONDecoder().decode(UserData.self, from: data)
                        
                           UserDefaults.standard.set(userData.user_id, forKey: "user_id")
                           UserDefaults.standard.set(userData.user_token, forKey: "user_token")
                          
                           DispatchQueue.main.async {
                               self.performSegue(withIdentifier: "prijelazNaListu", sender: nil)
                           }
                       }
                       catch{
                       print("ujme smo")
                       }
           })
           task.resume()
       }

    
    
}
   
