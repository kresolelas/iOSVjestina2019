//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Kreso Lelas on 22/06/2020.
//  Copyright © 2020 kreso. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    @IBOutlet weak var nameTxt: UILabel!
    
    @IBAction func logOutClicked(_ sender: Any) {
        resetDefaults()
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        if let userid = UserDefaults.standard.object(forKey: "user_id"){
            nameTxt.text="\(userid)"
        }
             super.viewDidLoad()
             }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
