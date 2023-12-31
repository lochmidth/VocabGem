//
//  RegisterViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

class RegisterViewModel {
    weak var coordinator: AuthCoordinating?
    let authService: AuthServicing
    let userService: UserServicing
    
    init(authService: AuthServicing = AuthService(), userService: UserServicing = UserService()) {
        self.authService = authService
        self.userService = userService
    }
    
    func dismissViewController() async {
        await coordinator?.dismiss()
    }
    
    func register(withCredentials credentials: AuthCredentials) async {
        do {
            try await authService.register(withCredentials: credentials)
            let user = try await userService.fetchUser()
            await coordinator?.didFinishAuth(withUser: user)
        } catch {
            await coordinator?.showMessage(withTitle: "Oops!", message: "Error while registering the user, \(error.localizedDescription)")
        }
    }
}
