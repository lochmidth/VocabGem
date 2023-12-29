//
//  HomeViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation
import FirebaseAuth

class homeViewModel {
    //MARK: - Properties
    
    weak var coordinator: TabBarCoordinator?
    let userService: UserService
    var user: User
    
    var greetingText: String {
        "Welcome, \(user.username)!"
    }
    
    //MARK - Lifecycle
    
    init(userService: UserService = UserService(), user: User) {
        self.userService = userService
        self.user = user
    }
    
    //MARK: - Helpers
        
    func didTapSearchButton(withWord word: String) {
        print("DEBUG: Searched word is \(word)")
        coordinator?.goToWord()
    }
}
