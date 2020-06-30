//
//  ViewController.swift
//  QuizApp
//
//  Created by Kreso Lelas on 11/05/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func checkLeaderBoard(_ sender: Any) {
        goToLeaderBoard()
    }
    @IBOutlet weak var questionsScrollView: UIScrollView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var funFactText: UILabel!
    @IBOutlet weak var errorView: UILabel!
    var startTime: NSDate?
    @IBAction func zapocniClicked(_ sender: Any) {
        startTime = NSDate() // start
         UIView.animate(withDuration: 0.2) {
             self.questionsScrollView.alpha=1
         }
   
    }
    var chosenQuiz:Quiz?
    var screenWidth = CGFloat()
    var userAnswers: [Bool] = []
    var currentQuestion = 0
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(userAnswered), name: Notification.Name("answered"), object: nil)
        questionsScrollView.alpha=0
        if chosenQuiz != nil {
            print(chosenQuiz?.title)
        }
        // Do any additional setup after loading the view.
        showData()
        
        //
    }
    
    @objc func userAnswered(notification: NSNotification){
        let correct : Bool = (notification.userInfo?["correct"]) as! Bool
              if correct==true {
                  //tocno
                  userAnswers.append(true)
              }else{
                  userAnswers.append(false)
        }
        //provjeri je li kraj igre
        if userAnswers.count >= (chosenQuiz?.questions.count)!{
            //sve smo odgovorili
            let end = NSDate()   //<<<<<<<<   end time
            let timeInterval: Double = end.timeIntervalSince(startTime as! Date) // <<<<< Difference in seconds (double)
             print("Potošeno vrijem:",timeInterval, "seconds")
            var numOfCorrect=0
            for odg in userAnswers {
                if odg{
                    numOfCorrect+=1
                }
            }
            submitResult(time: timeInterval, numOfCorrect: numOfCorrect)
            return
        }
        //idemo dalje nije gotovo
        currentQuestion+=1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.questionsScrollView.setContentOffset(CGPoint(x: (self.currentQuestion*Int(self.screenWidth)), y: 0), animated: true)
        }
       
       
    }

    
    func showData(){
        
        var numOfNba = 0
            for question in chosenQuiz!.questions{
                if question.question.contains("NBA"){
                    numOfNba+=1
                }
            }
        
        funFactText.text = String(numOfNba)
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        var index = 0
        for _ in chosenQuiz!.questions{
            //stvori sva pitanja jedan do drugog
            let questionsView = QuestionsView(frame: CGRect(x:(CGFloat(index)*screenWidth),y:0,width:screenWidth, height: 600))
            questionsView.showQuestionAndAnswers(quiz:chosenQuiz!, odabrano:index)
            self.questionsScrollView.addSubview(questionsView)
            index+=1
        }
       let url = URL(string:chosenQuiz!.image)
       
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.bgImage.image = UIImage(data: data!)
            }
        }
        
    }
    
    func submitResult(time: Double, numOfCorrect: Int){
      let userid = UserDefaults.standard.object(forKey: "user_id")
      let token = UserDefaults.standard.object(forKey: "user_token")
        print ("user token je ", token)
 
        let parameters = ["quiz_id": chosenQuiz?.id, "user_id": userid,"time": time,"no_of_correct":numOfCorrect]
        let url = URL(string: "https://iosquiz.herokuapp.com/api/result")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.addValue(token as! String, forHTTPHeaderField: "Authorization")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
          if let httpResponse = response as? HTTPURLResponse {
             //response
              if httpResponse.statusCode == 200{
                print("SUCCESS 200 Dodali smo na server")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
              }else{
                  //greškice
              }
          }
          
        })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if (segue.identifier == "toLeaderBoard") {
               print("segue preparean")
               let sDest = segue.destination as? LeaderboardsViewController
                sDest!.chosenQuizId = chosenQuiz?.id
              }
          }
    func goToLeaderBoard(){
                   //to je odabrani kviz salji te podatke i id dalje
                   performSegue(withIdentifier: "toLeaderBoard", sender: nil)
           }
}
