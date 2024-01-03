//
//  QuizViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class QuizViewModel {
    weak var coordinator: TabBarCoordinating?
    let quizManager: QuizManaging
    var user: User
    var score: Int
    
    var scoreText: String {
        "Score: \(score)"
    }
    
    init(user: User, quizManager: QuizManaging = QuizManager()) {
        self.user = user
        self.quizManager = quizManager
        self.score = user.score
        
        Task {
            await fetchQuizes()
        }
    }
    
    func fetchQuizes() async {
        do {
            try await quizManager.fetchQuizes()
        } catch {
            await coordinator?.showMessage(withTitle: "Oops!",
                                           message: "Error while fetching quizes, \(error.localizedDescription)")
        }
    }
    
    func updateScore() async {
        do {
            try await quizManager.updateScore(score: score)
        } catch {
            await coordinator?.showMessage(withTitle: "Oops!",
                                           message: "Error while updating the score for \(user.username), \(error.localizedDescription)")
        }
    }
    
    func checkIfAnswerIsCorrectAndHighlight(index: Int) -> UIColor {
        if quizManager.submitAnswer(atIndex: index) {
            score += 1
            Task {
                await updateScore()
            }
            quizManager.moveToNextQuestion()
            return UIColor.green
        } else {
            quizManager.moveToNextQuestion()
            return UIColor.red
        }
    }
}
