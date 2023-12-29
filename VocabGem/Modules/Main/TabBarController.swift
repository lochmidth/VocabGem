//
//  TabBarController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class TabBarController: UITabBarController {
    //MARK: - Properties
    
    var viewModel: TabBarViewModel?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    //MARK: - Helpers
    
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.scrollEdgeAppearance = appearance
        
        navigationItem.setHidesBackButton(true, animated: false)
    }
}
