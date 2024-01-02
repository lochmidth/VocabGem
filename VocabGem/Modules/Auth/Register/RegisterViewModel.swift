//
//  RegisterViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

class RegisterViewModel {
    weak var coordinator: AuthCoordinator?
    let authService: AuthService
    let userService: UserService
    
    init(authService: AuthService = AuthService(), userService: UserService = UserService()) {
        self.authService = authService
        self.userService = userService
    }
    
    func dismissViewController() {
        Task {
            await coordinator?.dismiss()
        }
    }
    
    func register(withCredentials credentials: AuthCredentials) {
        Task {
            do {
                try await authService.register(withCredentials: credentials)
                let user = try await userService.fetchUser()
                await coordinator?.didFinishAuth(withUser: user)
            } catch {
                await coordinator?.showMessage(withTitle: "Oops!", message: "Error while registering the user, \(error.localizedDescription)")
            }
        }
        
    }
}
