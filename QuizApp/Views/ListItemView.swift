//
//  ListItemView.swift
//  QuizApp
//
//  Created by sara on 08/06/2020.
//  Copyright © 2020 sara. All rights reserved.
//

import UIKit

class ListItemView: UIView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var quizDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var flame2: UIImageView!
    @IBOutlet weak var flame3: UIImageView!
    @IBOutlet weak var rootView: UIView!
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
   
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("ListItemView", owner:self, options:nil)
        addSubview(rootView)
        rootView.frame = self.bounds
    }
    
    
    func showQuizData(quiz: Quiz){
        
        quizDescription.text = quiz.quizDescription
        title.text = quiz.title
        if quiz.level < 3 {
            flame3.alpha = 0
            if quiz.level < 2{
                flame2.alpha = 0
            }
        }
        
        let url = URL(string: quiz.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data!)
            }
        }
        
    }
}
