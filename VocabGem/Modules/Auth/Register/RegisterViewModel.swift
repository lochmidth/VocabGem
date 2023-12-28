//
//  RegisterViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

class RegisterViewModel {
    weak var coordinator: AuthCoordinator?
    let authService: AuthService
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }
    
    func dismissViewController() {
        coordinator?.dismiss()
    }
    
    func register(withCredentials credentials: AuthCredentials) {
        Task {
            try await authService.register(withCredentials: credentials)
        }
        
    }
}
