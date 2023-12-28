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
//    var isViewPresented = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginPage()
    }
    
    func goToLoginPage() {
        let loginController = LoginController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginController.viewModel = loginViewModel
        navigationController.pushViewController(loginController, animated: false)
    }
    
    func goToRegisterPage() {
        let registerController = RegisterController()
        let registerViewModel = RegisterViewModel()
        registerViewModel.coordinator = self
        registerController.viewModel = registerViewModel
        navigationController.pushViewController(registerController, animated: true)
    }
    
    func didFinishAuth() {
        parentCoordinator?.childDidFinish(self)
        navigationController.popToRootViewController(animated: false)
        parentCoordinator?.goToHome()
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
