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
        coordinator?.dismiss()
    }
    
    func register(withCredentials credentials: AuthCredentials) {
        Task {
            try await authService.register(withCredentials: credentials)
            let user = try await userService.fetchUser()
            await MainActor.run(body: {
                coordinator?.didFinishAuth(withUser: user)
            })
        }
        
    }
}
