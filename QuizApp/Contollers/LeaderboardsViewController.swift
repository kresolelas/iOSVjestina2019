//
//  LeaderboardsViewController.swift
//  QuizApp
//
//  Created by Kreso Lelas on 22/06/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import UIKit

class LeaderboardsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    var chosenQuizId:Int?
    var playerModels:[String] = []
    @IBAction func klik(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        getLeaderBoard()
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    func getLeaderBoard(){
        //print(chosenQuizId)
        let service = QuizServis()
        service.getLeaderBoards2(quizId: chosenQuizId!)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.playerModels.count
       }
       
       // create a cell for each table view row
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
           
        // set the text from the data model
        var title = ""
          
        cell.textLabel?.text = title
           
        return cell
       }
       
       // method to run when table view cell is tapped
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("You tapped cell number \(indexPath.row).")
           //chosenQuiz = quiz
           print("kliknli na kviz")
           //to je odabrani kviz salji te podatke i id dalje
         
       }
       
       
          
          
          // cell reuse id (cells that scroll out of view can be reused)
          let cellReuseIdentifier = "cell"
}
