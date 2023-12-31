//
//  QuizManager.swift
//  VocabGem
//
//  Created by Alphan Ogün on 1.01.2024.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

enum QuizError: Error {
    case fetchingError
    case updateError
}

protocol QuizManaging {
    var questions: [Quiz] { get set }
    var index: Int { get set }
    func submitAnswer(atIndex index: Int) -> Bool
    func moveToNextQuestion()
    func resetQuiz()
    func fetchQuizes() async throws
    func updateScore(score: Int) async throws
}

class QuizManager: QuizManaging {
    var questions: [Quiz] = []
    var index = 0
    
    private func getCurrentQuestion() -> Quiz {
        if index < questions.count - 1 {
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
    
    func fetchQuizes() async throws {
        return try await withCheckedThrowingContinuation({ continuation in
            REF_QUIZES.observe(.childAdded) { snapshot in
                guard let dictionary = snapshot.value else {
                    continuation.resume(throwing: QuizError.fetchingError)
                    return
                }
                let quiz = Quiz(dictionary: dictionary as! [String: Any])
                self.questions.append(quiz)
                
                if self.questions.count == snapshot.childrenCount {
                    continuation.resume(returning: ())
                }
            }
        })
    }
    
    func updateScore(score: Int) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { throw QuizError.updateError }
        try await REF_USERS.child(uid).child("score").setValue(score)
    }
}
