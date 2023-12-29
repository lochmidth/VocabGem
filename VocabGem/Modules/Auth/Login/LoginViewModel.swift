//
//  AuthViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import Foundation

class LoginViewModel {
    
    weak var coordinator: AuthCoordinating?
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
                let user = try await userService.fetchUser()
                await MainActor.run {
                    coordinator?.didFinishAuth(withUser: user)
                }
            } catch {
                print("DEBUG: Error while logging in, \(error.localizedDescription)")
            }
        }
    }
    
}
