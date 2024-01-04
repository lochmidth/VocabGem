//
//  Quiz.swift
//  VocabGem
//
//  Created by Alphan Ogün on 31.12.2023.
//

import Foundation

struct Quiz {
    let question: String
    let choices: [String]
    let correctAnswerIndex: Int
    
    init(dictionary: [String: Any] ) {
        self.question = dictionary["question"] as? String ?? ""
        self.choices = dictionary["answers"] as? [String] ?? ["","",""]
        self.correctAnswerIndex = dictionary["correctAnswerIndex"] as? Int ?? 0
    }
}
