//
//  AuthViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    weak var coordinator: AuthCoordinator?
    let authService: AuthService
    let userService: UserService
    
    init(authService: AuthService = AuthService(), userService: UserService = UserService()) {
        self.authService = authService
        self.userService = userService
    }
    
    func handleShowRegister() {
        coordinator?.goToRegisterPage()
    }
    
    func handleLogin(email: String, password: String) {
        Task {
            do {
                try await authService.login(withEmail: email, password: password)
                DispatchQueue.main.async {
                    self.coordinator?.didFinishAuth()
                }
            } catch {
                print("DEBUG: Error while logging in, \(error.localizedDescription)")
            }
        }
    }
    
}
