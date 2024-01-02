//
//  SplashViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation

class SplashViewModel {
    weak var coordinator: AppCoordinator?
    let userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func checkForAuth() async {
        let status = userService.checkIfUserIsLoggedIn()
        switch status {
        case true:
            do {
                let user = try await userService.fetchUser()
                await coordinator?.goToTabBar(withUser: user)
            } catch {
                await coordinator?.showMessage(withTitle: "Oops!",
                                         message: "Error while authenticating the user, \(error.localizedDescription)")
            }
        case false:
            await coordinator?.goToAuth()
        }
    }
}
