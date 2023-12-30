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
    let googleService: GoogleService
    
    init(authService: AuthService = AuthService(), userService: UserService = UserService(), googleService: GoogleService = GoogleService()) {
        self.authService = authService
        self.userService = userService
        self.googleService = googleService
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
    
    func handleLoginWithGoogle() {
        Task {
            let user = try await googleService.signInWithGoogle()
            await MainActor.run(body: {
                coordinator?.didFinishAuth(withUser: user)
            })
        }
    }
}
