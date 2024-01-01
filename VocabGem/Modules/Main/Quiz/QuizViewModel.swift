//
//  QuizViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class QuizViewModel {
    weak var coordinator: TabBarCoordinator?
    let quizManager: QuizManager
    var user: User
    
    var scoreText: String {
        "Score: \(user.score)"
    }
    
    init(user: User, quizManager: QuizManager = QuizManager()) {
        self.user = user
        self.quizManager = quizManager
        
        fetchQuizes()
    }
    
    func fetchQuizes() {
        Task {
            do {
                try await quizManager.fetchQuizes()
            } catch {
                print("DEBUG: Error while fetching quizes, \(error.localizedDescription)")
            }
        }
    }
    
    private func updateScore() {
        Task {
            do {
                try await quizManager.updateScore()
            } catch {
                print("DEBUG: Error while updating the score for \(user.username), \(error.localizedDescription)")
            }
        }
    }
    
    func checkIfAnswerIsCorrectAndHighlight(index: Int) -> UIColor {
        if quizManager.submitAnswer(atIndex: index) {
            quizManager.score += 1
            updateScore()
            quizManager.moveToNextQuestion()
            return UIColor.green
        } else {
            quizManager.moveToNextQuestion()
            return UIColor.red
        }
    }
}
