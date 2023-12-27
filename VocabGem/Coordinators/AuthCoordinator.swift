//
//  AuthCoordinator.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit

class AuthCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    var isViewPresented = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSplash()
    }
    
    private func goToSplash() {
        let splashController = SplashController()
        let splashViewModel = SplashViewModel()
        splashViewModel.coordinator = self
        splashController.viewModel = splashViewModel
        navigationController.pushViewController(splashController, animated: false)
    }
    
    func goToLoginPage() {
        let loginController = AuthController()
        let loginViewModel = AuthViewModel()
        loginViewModel.coordinator = self
        loginController.viewModel = loginViewModel
        navigationController.pushViewController(loginController, animated: false)
    }
}
