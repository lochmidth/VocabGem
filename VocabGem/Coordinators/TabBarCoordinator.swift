//
//  TabBarCoordinator.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

@MainActor
protocol TabBarCoordinating: Coordinator {
    func configureTabBarController()
    func goToWord(word: Word)
    func signOut() async throws
}

class TabBarCoordinator: TabBarCoordinating {
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
    
    func configureTabBarController() {
        let tabBarViewModel = TabBarViewModel()
        tabBarViewModel.coordinator = self
        let tabBarController = TabBarController(viewModel: tabBarViewModel)
        
        let homeViewModel = HomeViewModel(user: user)
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
    
    func goToWord(word: Word) {
        let wordViewModel = WordViewModel(word: word)
        wordViewModel.coordinator = self
        let wordController = WordController(viewModel: wordViewModel)
        navigationController.pushViewController(wordController, animated: true)
    }
    
    func signOut() async throws {
        Task {
            navigationController.popToRootViewController(animated: true)
            parentCoordinator?.childDidFinish(self)
        }
    }
    
    
//    func showMessage(withTitle title: String, message: String) {
//        parentCoordinator?.showMessage(withTitle: title, message: message)
//    }
    
}
