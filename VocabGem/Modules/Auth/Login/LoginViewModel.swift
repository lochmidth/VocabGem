//
//  AuthViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import Foundation

class LoginViewModel {
    
    weak var coordinator: AuthCoordinator?
    let authService: AuthService
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }
    
    func handleShowRegister() {
        coordinator?.goToRegisterPage()
    }
    
    func handleLogin(email: String, password: String) {
        Task {
            do {
                try await authService.login(withEmail: email, password: password)
            } catch {
                print("DEBUG: Error while logging in, \(error.localizedDescription)")
            }
        }
    }
    
}
