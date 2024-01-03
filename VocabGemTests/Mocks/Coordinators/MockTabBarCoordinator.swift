//
//  MockTabBarCoordinator.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import UIKit
@testable import VocabGem

class MockTabBarCoordinator: TabBarCoordinating {
    
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
    var signOutShouldFail = false
    
    func signOut() async throws {
        isSignOutCalled = true
        
        if signOutShouldFail {
            throw MockError.someError
        }
       
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

