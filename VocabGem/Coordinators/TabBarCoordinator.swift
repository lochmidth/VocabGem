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
        let tabBarController = TabBarController()
        let tabBarViewModel = TabBarViewModel()
        tabBarViewModel.coordinator = self
        tabBarController.viewModel = tabBarViewModel
        
        tabBarController.viewModel?.fetchUser(completion: { [weak self] user in
            
            let homeController = HomeController()
            let homeViewModel = homeViewModel(user: user)
            homeViewModel.coordinator = self
            homeController.viewModel = homeViewModel
            homeController.tabBarItem = UITabBarItem(title: "Home",
                                                     image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal),
                                                     selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal))
            let quizController = QuizController()
            let quizViewModel = QuizViewModel(user: user)
            quizViewModel.coordinator = self
            quizController.viewModel = quizViewModel
            quizController.tabBarItem = UITabBarItem(title: "Quiz",
                                                     image: UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysOriginal),
                                                     selectedImage: UIImage(systemName: "questionmark.circle.fill")?.withRenderingMode(.alwaysOriginal))
            
            tabBarController.viewControllers = [homeController, quizController]
            
            self?.navigationController.pushViewController(tabBarController, animated: true)
        })
    }
    
    func goToWord() {
        let wordController = WordController()
        let wordViewModel = WordViewModel()
        wordViewModel.coordinator = self
        wordController.viewModel = wordViewModel
        navigationController.pushViewController(wordController, animated: true)
    }
    
}
