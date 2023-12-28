//
//  TabBarCoordinator.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
       configureTabBarController()
    }
    
    private func configureTabBarController() {
        let tabBarController = UITabBarController()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        
        tabBarController.navigationItem.setHidesBackButton(true, animated: false)
        
        let homeController = HomeController()
        homeController.tabBarItem = UITabBarItem(title: "Home",
                                                 image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal))
        let quizController = QuizController()
        quizController.tabBarItem = UITabBarItem(title: "Quiz",
                                                 image: UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(systemName: "questionmark.circle.fill")?.withRenderingMode(.alwaysOriginal))
        
        tabBarController.viewControllers = [homeController, quizController]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
}
