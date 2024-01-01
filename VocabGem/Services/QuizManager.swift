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

class QuizManager {
    var questions: [Quiz] = []
    var index = 0
    var score: Int = 0
    
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
    
    func updateScore() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { throw QuizError.updateError }
        do {
            try await REF_USERS.child(uid).child("score").setValue(score)
        } catch {
            throw error
        }
    }
}
