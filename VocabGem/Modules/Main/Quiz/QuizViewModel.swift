//
//  QuizViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation

class QuizViewModel {
    weak var coordinator: TabBarCoordinator?
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
}
