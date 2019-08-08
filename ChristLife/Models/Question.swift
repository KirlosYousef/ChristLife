//
//  Question.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 08. 05..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let correctAnswer: Int
    
    init(question: String, optionA: String, optionB: String, optionC: String, correctAnswer: Int) {
        self.question = question
        self.optionA = optionA
        self.optionB = optionB
        self.optionC = optionC
        self.correctAnswer = correctAnswer
    }
}
