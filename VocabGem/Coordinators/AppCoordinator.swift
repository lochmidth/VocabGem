//
//  AppCoordinator.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit
import FirebaseAuth

@MainActor
protocol Coordinator: AnyObject {
    var navigationController : UINavigationController { get set }
    func start()
    func showMessage(withTitle title: String, message: String)
}

extension Coordinator {
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        navigationController.present(alert, animated: true)
    }
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSplash()
    }
    
    private func goToSplash() {
        let splashViewModel = SplashViewModel()
        splashViewModel.coordinator = self
        let splashController = SplashController(viewModel: splashViewModel)
        navigationController.pushViewController(splashController, animated: false)
    }
    
    func goToAuth() {
        let child = AuthCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func goToTabBar(withUser user: User) {
        if let existingHomeController = childCoordinators.first(where: { $0 is TabBarCoordinator }) as? TabBarCoordinator {
            existingHomeController.user = user
        } else {
            let child = TabBarCoordinator(navigationController: navigationController, user: user)
            child.parentCoordinator = self
            childCoordinators.append(child)
            child.start()
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
//    func showMessage(withTitle title: String, message: String) {
//        navigationController.showMessage(withTitle: title, message: message)
//    }
}
