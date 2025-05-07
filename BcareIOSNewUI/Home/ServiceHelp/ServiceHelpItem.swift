//
//  BookingGrid.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation

class ServiceHelpItem:Equatable,Hashable {
    let service:String
    let questions:[ServiceQuestionItem]
    init(service: String, questions: [ServiceQuestionItem]) {
        self.service = service
        self.questions = questions
    }
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: ServiceHelpItem, rhs: ServiceHelpItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class ServiceQuestionItem:Equatable,Hashable {
    let question:String
    let answer:String
    var isExpanded:Bool
    init(question: String, answer: String, isExpanded: Bool = false) {
        self.question = question
        self.answer = answer
        self.isExpanded = isExpanded
    }
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: ServiceQuestionItem, rhs: ServiceQuestionItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
