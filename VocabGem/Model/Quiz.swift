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

// Questions
//var vocabularyQuizQuestions: [Quiz] = [
//    Quiz(
//        question: "What is the synonym of the word 'Happy'?",
//        choices: ["Joyful", "Sad", "Angry"],
//        correctAnswerIndex: 0
//    ),
//    Quiz(
//        question: "How would you define the term 'Brave'?",
//        choices: ["Cautious", "Timid", "Courageous"],
//        correctAnswerIndex: 2
//    ),
//    Quiz(
//        question: "What does the word 'Simple' mean?",
//        choices: ["Complicated", "Easy", "Difficult"],
//        correctAnswerIndex: 1
//    ),
//    Quiz(
//        question: "Which of the following best describes the word 'Calm'?",
//        choices: ["Stressful", "Chaotic", "Peaceful"],
//        correctAnswerIndex: 2
//    ),
//    Quiz(
//        question: "Define the term 'Generous'.",
//        choices: ["Giving", "Selfish", "Greedy"],
//        correctAnswerIndex: 0
//    ),
//    Quiz(
//        question: "What does the word 'Famous' mean?",
//        choices: ["Well-known", "Unknown", "Obscure"],
//        correctAnswerIndex: 0
//    ),
//    Quiz(
//        question: "How would you characterize something that is 'Useful'?",
//        choices: ["Destructive", "Harmful", "Beneficial"],
//        correctAnswerIndex: 2
//    ),
//    Quiz(
//        question: "What is the opposite of the term 'Weak'?",
//        choices: ["Frail", "Strong", "Feeble"],
//        correctAnswerIndex: 1
//    ),
//    Quiz(
//        question: "What does it mean to be 'Clever'?",
//        choices: ["Smart", "Dull", "Stupid"],
//        correctAnswerIndex: 0
//    ),
//    Quiz(
//        question: "If something is 'Common,' how often is it found?",
//        choices: ["Occasionally", "Rarely", "Frequently"],
//        correctAnswerIndex: 0
//    )
//]
