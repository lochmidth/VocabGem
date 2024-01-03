//
//  LoginViewModelTests.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import XCTest
@testable import VocabGem

@MainActor
final class LoginViewModelTests: XCTestCase {
    
    var mockAuthService: MockAuthService!
    var mockUserService: MockUserService!
    var mockGoogleService: MockGoogleService!
    var mockCoordinator: MockAuthCoordinator!
    var sut: LoginViewModel!
    
    override func setUpWithError() throws {
        mockAuthService = MockAuthService()
        mockUserService = MockUserService()
        mockGoogleService = MockGoogleService()
        mockCoordinator = MockAuthCoordinator()
        
        sut = LoginViewModel(authService: mockAuthService, userService: mockUserService, googleService: mockGoogleService)
        sut.coordinator = mockCoordinator
        
    }
    
    func test_handleShowRegister_GoToRegister() async {
        //GIVEN
        
        //WHEN
        await sut.handleShowRegister()
        
        //THEN
        XCTAssertTrue(mockCoordinator.isGoToRegisterPageCalled)
    }
    
    //FIXME: - isFetchUSerCalled and isDidFinishWithAuth not working
    func test_handleLogin_givenValidCredentials_thenSuccess() async {
        //GIVEN
        let password = "correctPassword"
        mockAuthService.loginResult = .success(true)
        mockUserService.fetchUserResult = .success(mockUser)
        
        //WHEN
        await sut.handleLogin(email: mockUser.email, password: password)
        
        //THEN
        XCTAssertTrue(mockAuthService.isLoginCalled)
        XCTAssertTrue(mockUserService.isFetchUserCalled)
        XCTAssertTrue(mockCoordinator.isDidFinishWithAuth)
    }
    
    func test_handleLogin_givenInvalidCredentials_thenFail() async {
        //GIVEN
        let password = "wrongPassword"
        mockAuthService.loginResult = .failure(MockError.someError)
        mockAuthService.loginShouldFail = true
        
        //WHEN
        await sut.handleLogin(email: mockUser.email, password: password)
        
        //THEN
        XCTAssertTrue(mockAuthService.isLoginCalled)
        XCTAssertFalse(mockUserService.isFetchUserCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
    
    func test_handleLoginWithGoogle_givenValidCredentials_thenSucces() async {
        //GIVEN
        mockGoogleService.signInWithGoogleResult = .success(mockUser)
        
        //WHEN
        await sut.handleLoginWithGoogle()
        
        //THEN
        XCTAssertTrue(mockGoogleService.isSignInWithGoogleCalled)
        XCTAssertTrue(mockCoordinator.isDidFinishWithAuth)
    }
    
    func test_handleLoginWithGoogle_givenInValidCredentials_thenFail() async {
        //GIVEN
        mockGoogleService.signInWithGoogleResult = .failure(MockError.someError)
        mockGoogleService.signInWithGoogleShouldFail = true
        
        //WHEN
        await sut.handleLoginWithGoogle()
        
        //THEN
        XCTAssertTrue(mockGoogleService.isSignInWithGoogleCalled)
        XCTAssertFalse(mockCoordinator.isDidFinishWithAuth)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
}
