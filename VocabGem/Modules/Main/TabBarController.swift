//
//  TabBarController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class TabBarController: UITabBarController {
    //MARK: - Properties
    
    var viewModel: TabBarViewModel
    
    //MARK: - Lifecycle
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureNavBar()
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Actions
    
    @objc func handleSignOut() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            self.viewModel.handleSignOut()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGroupedBackground
        tabBar.scrollEdgeAppearance = appearance
        
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func configureNavBar() {
        let appereance = UINavigationBarAppearance()
        appereance.configureWithOpaqueBackground()
        appereance.backgroundColor = .systemGroupedBackground
        navigationItem.standardAppearance = appereance
        navigationItem.scrollEdgeAppearance = appereance
        navigationItem.compactAppearance = appereance
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        
        let signOutIcon = UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: signOutIcon, style: .done, target: self, action: #selector(handleSignOut))
    }
}
