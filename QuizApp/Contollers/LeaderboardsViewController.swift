//
//  LeaderboardsViewController.swift
//  QuizApp
//
//  Created by Kreso Lelas on 22/06/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import UIKit

class LeaderboardsViewController: UIViewController {
    var chosenQuizId:Int?
    @IBAction func klik(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
          getLeaderBoard()
          super.viewDidLoad()
          }
    func getLeaderBoard(){
        //print(chosenQuizId)
        let service = QuizServis()
        service.getLeaderBoards2(quizId: chosenQuizId!)
    }
}
