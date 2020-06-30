//
//  QuizDataModel+CoreDataProperties.swift
//  QuizApp
//
//  Created by Kreso Lelas on 23/06/2020.
//  Copyright © 2020 sara. All rights reserved.
//
//

import Foundation
import CoreData


extension QuizDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizDataModel> {
        return NSFetchRequest<QuizDataModel>(entityName: "QuizDataModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var quizDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var level: Int32
    @NSManaged public var image: String?
    @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for questions
extension QuizDataModel {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: QuestionDataModel)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: QuestionDataModel)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
