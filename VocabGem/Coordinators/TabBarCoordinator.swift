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
    var user: User
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        let tabBarViewModel = TabBarViewModel()
        tabBarViewModel.coordinator = self
        let tabBarController = TabBarController(viewModel: tabBarViewModel)
        
        let homeViewModel = homeViewModel(user: user)
        homeViewModel.coordinator = self
        let homeController = HomeController(viewModel: homeViewModel)
        homeController.tabBarItem = UITabBarItem(title: "Home",
                                                 image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal))
        
        let quizViewModel = QuizViewModel(user: user)
        quizViewModel.coordinator = self
        let quizController = QuizController(viewModel: quizViewModel)
        quizController.tabBarItem = UITabBarItem(title: "Quiz",
                                                 image: UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(systemName: "questionmark.circle.fill")?.withRenderingMode(.alwaysOriginal))
        
        tabBarController.viewControllers = [homeController, quizController]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func goToWord() {
        let wordViewModel = WordViewModel()
        wordViewModel.coordinator = self
        let wordController = WordController(viewModel: wordViewModel)
        navigationController.pushViewController(wordController, animated: true)
    }
    
    func signOut() {
        navigationController.popToRootViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
    
}
