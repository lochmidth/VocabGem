//
//  AppCoordinator.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit
import FirebaseAuth

protocol Coordinator: AnyObject {
    var navigationController : UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print("DEBUG: Error while signOut, \(error.localizedDescription)")
//        }
        
        if Auth.auth().currentUser == nil {
            goToAuth()
        } else {
            goToHome()
        }
    }
    
    private func goToAuth() {
        let child = AuthCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func goToHome() {
        let child = TabBarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
