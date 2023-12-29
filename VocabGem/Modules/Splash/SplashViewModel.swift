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
    
    func checkForAuth() {
        let status = userService.checkIfUserIsLoggedIn()
        
        switch status {
        case true:
            Task {
                let user = try await userService.fetchUser()
                await MainActor.run {
                    coordinator?.goToTabBar(withUser: user)
                }
            }
//            userService.fetchUser { [weak self] user in
//                self?.coordinator?.goToTabBar(withUser: user)
//            }
        case false:
            coordinator?.goToAuth()
        }
    }
}
