//
//  QuestionDataModel+CoreDataProperties.swift
//  QuizApp
//
//  Created by Kreso Lelas on 23/06/2020.
//  Copyright © 2020 sara. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionDataModel> {
        return NSFetchRequest<QuestionDataModel>(entityName: "QuestionDataModel")
    }

    @NSManaged public var question: String?
    @NSManaged public var answers: NSObject?
    @NSManaged public var correctAnswer: Int32
    @NSManaged public var parentQuiz: QuizDataModel?

}
