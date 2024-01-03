//
//  MockQuizManager.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import Foundation
@testable import VocabGem

class MockQuizManager: QuizManaging {
    var questions: [VocabGem.Quiz] = []
    
    var index: Int = 0
    
    func getCurrentQuestion() -> Quiz {
        if index < questions.count {
            return questions[index]
        } else {
            resetQuiz()
            return questions[index]
        }
    }
    
    func submitAnswer(atIndex index: Int) -> Bool {
        return index == getCurrentQuestion().correctAnswerIndex
    }
    
    func moveToNextQuestion() {
        index += 1
    }
    
    func resetQuiz() {
        index = 0
    }
    
    var fetchQuizesResult: Result<[Quiz], Error>?
    var isFetchQuizesCalled = false
    
    func fetchQuizes() async throws {
       isFetchQuizesCalled = true
        
        if let fetchQuizesResult = fetchQuizesResult {
            switch fetchQuizesResult {
            case .success(let responses):
                responses.forEach { response in
                    questions.append(response)
                }
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var updateScoreResult: Result<Bool, Error>?
    var isUpdateScoreCalled = false
    
    func updateScore(score: Int) async throws {
        isUpdateScoreCalled = true
        
        if let updateScoreResult = updateScoreResult {
            switch updateScoreResult {
            case .success:
                return
            case .failure(let error):
                throw error
            }
        } else {
            MockError.someError
        }
    }
}
