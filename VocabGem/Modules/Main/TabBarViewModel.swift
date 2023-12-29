//
//  TabBarViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation
import FirebaseAuth

class TabBarViewModel {
    //MARK: - Properties
    
    weak var coordinator: TabBarCoordinator?
    let userService: UserService
    
    //MARK: - Lifecycle
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    //MARK: - Helpers
    
    func handleSignOut() {
        do {
            try Auth.auth().signOut()
            coordinator?.signOut()
        } catch {
            print("DEBUG: Error while signOut, \(error.localizedDescription)")
        }
    }
}
