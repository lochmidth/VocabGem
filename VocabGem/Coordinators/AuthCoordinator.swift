//
//  AuthCoordinator.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit

@MainActor
protocol AuthCoordinating: Coordinator {
    func goToLoginPage()
    func goToRegisterPage()
    func didFinishAuth(withUser user: User)
    func dismiss()
}

class AuthCoordinator: AuthCoordinating {
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginPage()
    }
    
    func goToLoginPage() {
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        let loginController = LoginController(viewModel: loginViewModel)
        navigationController.pushViewController(loginController, animated: false)
    }
    
    func goToRegisterPage() {
        let registerViewModel = RegisterViewModel()
        registerViewModel.coordinator = self
        let registerController = RegisterController(viewModel: registerViewModel)
        navigationController.pushViewController(registerController, animated: true)
    }
    
    func didFinishAuth(withUser user: User) {
        parentCoordinator?.childDidFinish(self)
        navigationController.popToRootViewController(animated: false)
        parentCoordinator?.goToTabBar(withUser: user)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
