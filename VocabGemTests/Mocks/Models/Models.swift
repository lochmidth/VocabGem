//
//  Models.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import Foundation
@testable import VocabGem

//MARK: - User

let mockUserDictionary: [String: Any] = [
    "email": "mock@example.com",
    "fullname": "Mock User",
    "username": "mockuser",
    "score": 100,
    "uid": "mockUserID"
]

let mockUser = User(uid: mockUserDictionary["uid"] as! String, dictionary: mockUserDictionary)

//MARK: - Words

let mockWords: Words = {
    let mockResults = Results(total: 5, data: ["Apple", "Banana", "Orange", "Grapes", "Pineapple"])
    return Words(results: mockResults)
}()

var mockEmptyWords: Words = {
    let mockResults = Results(total: 0, data: [])
    return Words(results: mockResults)
}()

//MARK: - Word

let mockWord: Word = {
    let mockResult = WordResult(
        definition: "The round fruit of a tree of the rose family, which typically has thin red or green skin and crisp flesh.",
        partOfSpeech: "Noun",
        synonyms: ["Fruit", "Pomaceous fruit"],
        examples: ["I had an apple for a snack."]
    )
    
    return Word(word: "Apple", results: [mockResult])
}()

//MARK: - Quiz

let mockQuizDictionary1: [String: Any] = [
    "question": "What is the capital of France?",
    "answers": ["Berlin", "Paris", "London"],
    "correctAnswerIndex": 1
]

let mockQuizDictionary2: [String: Any] = [
    "question": "Which planet is known as the Red Planet?",
    "answers": ["Earth", "Mars", "Jupiter"],
    "correctAnswerIndex": 1
]


let mockQuiz1 = Quiz(dictionary: mockQuizDictionary1)
let mockQuiz2 = Quiz(dictionary: mockQuizDictionary2)



