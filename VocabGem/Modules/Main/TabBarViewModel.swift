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
    
    weak var coordinator: TabBarCoordinating?
    let userService: UserService
    
    //MARK: - Lifecycle
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    //MARK: - Helpers
    
    func handleSignOut() async {
        do {
            try Auth.auth().signOut()
            await coordinator?.signOut()
        } catch {
            await coordinator?.showMessage(withTitle: "Oops!", message: "Error While signing the user out, \(error.localizedDescription)")
        }
    }
}
