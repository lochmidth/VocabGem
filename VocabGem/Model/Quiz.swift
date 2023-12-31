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
}

// Questions
var vocabularyQuizQuestions: [Quiz] = [
    Quiz(
        question: "What is the synonym of the word 'Happy'?",
        choices: ["Joyful", "Sad", "Angry"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "How would you define the term 'Brave'?",
        choices: ["Courageous", "Timid", "Cautious"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "What does the word 'Simple' mean?",
        choices: ["Easy", "Complicated", "Difficult"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "Which of the following best describes the word 'Calm'?",
        choices: ["Peaceful", "Chaotic", "Stressful"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "Define the term 'Generous'.",
        choices: ["Giving", "Selfish", "Greedy"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "What does the word 'Famous' mean?",
        choices: ["Well-known", "Unknown", "Obscure"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "How would you characterize something that is 'Useful'?",
        choices: ["Beneficial", "Harmful", "Destructive"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "What is the opposite of the term 'Weak'?",
        choices: ["Strong", "Frail", "Feeble"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "What does it mean to be 'Clever'?",
        choices: ["Smart", "Dull", "Stupid"],
        correctAnswerIndex: 0
    ),
    Quiz(
        question: "If something is 'Common,' how often is it found?",
        choices: ["Frequently", "Rarely", "Occasionally"],
        correctAnswerIndex: 0
    )
]
