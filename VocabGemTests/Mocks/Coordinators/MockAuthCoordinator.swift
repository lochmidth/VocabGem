//
//  MockAuthCoordinator.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import UIKit
@testable import VocabGem

class MockAuthCoordinator: AuthCoordinating {
    var navigationController = UINavigationController()
    
    var isGoToLoginPageCalled = false
    func goToLoginPage() {
        isGoToLoginPageCalled = true
    }
    
    var isGoToRegisterPageCalled = false
    func goToRegisterPage() {
        isGoToRegisterPageCalled = true
    }
    
    var isDidFinishWithAuth = false
    func didFinishAuth(withUser user: VocabGem.User) {
        isDidFinishWithAuth = true
    }
    
    var isDismissCalled = false
    func dismiss() {
        isDismissCalled = true
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
