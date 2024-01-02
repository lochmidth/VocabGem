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
    let googleService: GoogleServicing
    
    init(authService: AuthService = AuthService(), userService: UserService = UserService(), googleService: GoogleServicing = GoogleService()) {
        self.authService = authService
        self.userService = userService
        self.googleService = googleService
    }
    
    func handleShowRegister() async {
        await coordinator?.goToRegisterPage()
    }
    
    func handleLogin(email: String, password: String) async  {
        do {
            try await authService.login(withEmail: email, password: password)
            let user = try await userService.fetchUser()
            await coordinator?.didFinishAuth(withUser: user)
        } catch {
            await coordinator?.showMessage(withTitle: "Oops!", message: "Error while logging in, \(error.localizedDescription)")
        }
    }
    
    func handleLoginWithGoogle() async {
        do {
            let user = try await googleService.signInWithGoogle()
            await coordinator?.didFinishAuth(withUser: user)
        } catch {
            await coordinator?.showMessage(withTitle: "Oops!", message: "Error while Login with Google Service, \(error.localizedDescription)")
        }
    }
}
