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
    let userService: UserServicing
    let auth: Auth
    
    //MARK: - Lifecycle
    
    init(userService: UserServicing = UserService(), auth: Auth = Auth.auth()) {
        self.userService = userService
        self.auth = auth
    }
    
    //MARK: - Helpers
    
    func handleSignOut() async {
        do {
            try auth.signOut()
            try await coordinator?.signOut()
        } catch {
            await coordinator?.showMessage(withTitle: "Oops!", message: "Error While signing the user out, \(error.localizedDescription)")
        }
    }
}
