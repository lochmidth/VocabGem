//
//  SplashViewModelTests.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import XCTest
@testable import VocabGem

final class SplashViewModelTests: XCTestCase {
    
    var mockUserService: MockUserService!
//    var coordinator: 
    var sut: SplashViewModel!
    
    override func setUpWithError() throws {
        mockUserService = MockUserService()
        sut = SplashViewModel(userService: mockUserService)
    }
    
    func test_checkForAuth_UserIsLoggedIn_NavigateToTabBar() async {
        //GIVEN
        mockUserService.isLoggedIn = true
        mockUserService.fetchUserResult = .success(mockUser)
        
        //WHEN
        await sut.checkForAuth()
        
        //THEN
        XCTAssertTrue(mockUserService.isCheckIfUserIsLoggedInCalled)
        XCTAssertTrue(mockUserService.isFetchUserCalled)
    }
    
    func test_checkForAuth_UserIsNotLoggedIn_NavigateToAuth() async {
        //GIVEN
        mockUserService.isLoggedIn = false
        
        //WHEN
        await sut.checkForAuth()
        
        //THEN
        XCTAssertTrue(mockUserService.isCheckIfUserIsLoggedInCalled)
        XCTAssertFalse(mockUserService.isFetchUserCalled)
    }
    
    func test_checkForAuth_withError_thenError() async {
        //GIVEN
        mockUserService.isLoggedIn = true
        mockUserService.fetchUserResult = nil
        
        //WHEN
        await sut.checkForAuth()
        
        //THEN
        XCTAssertTrue(mockUserService.isCheckIfUserIsLoggedInCalled)
        XCTAssertTrue(mockUserService.isFetchUserCalled)
    }
    
    
}
