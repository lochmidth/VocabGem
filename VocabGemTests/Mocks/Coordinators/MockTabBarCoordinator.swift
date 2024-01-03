//
//  MockTabBarCoordinator.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import UIKit
@testable import VocabGem

class MockTabBarController: TabBarCoordinating {
    
    var navigationController = UINavigationController()
    
    var isConfigureTabBarControllerCalled = false
    func configureTabBarController() {
        isConfigureTabBarControllerCalled = true
    }
    
    var isGoToWordCalled = false
    func goToWord(word: VocabGem.Word) {
        isGoToWordCalled = true
    }
    
    var isSignOutCalled = false
    func signOut() {
        isSignOutCalled = true
    }

    var isStartCalled = false
    func start() {
        isStartCalled = true
    }
    
    var isShowMessageCalled = false
    func showMessage(withTitle title: String, message: String) {
        isShowMessageCalled = true
    }
    
    
}

