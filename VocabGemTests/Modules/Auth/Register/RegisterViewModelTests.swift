//
//  RegisterViewModelTests.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import XCTest
@testable import VocabGem

@MainActor
final class RegisterViewModelTests: XCTestCase {

    var mockCoordinator: MockAuthCoordinator!
    var mockAuthService: MockAuthService!
    var mockUserService: MockUserService!
    var sut: RegisterViewModel!
    
    override func setUpWithError() throws {
        mockCoordinator = MockAuthCoordinator()
        mockAuthService = MockAuthService()
        mockUserService = MockUserService()
        sut = RegisterViewModel(authService: mockAuthService, userService: mockUserService)
        sut.coordinator = mockCoordinator
    }
    
    func test_dismissViewController_Dismiss() async {
        //GIVEN
        
        //WHEN
        await sut.dismissViewController()
        
        //THEN
        XCTAssertTrue(mockCoordinator.isDismissCalled)
    }
    
    func test_register_givenValidCredentials_thenSuccess() async {
        //GIVEN
        let password = "validPassword"
        let credentials = AuthCredentials(email: mockUser.email,
                                          password: password,
                                          fullname: mockUser.fullname,
                                          username: mockUser.username)
        mockAuthService.registerResult = .success(true)
        mockUserService.fetchUserResult = .success(mockUser)
        
        //WHEN
        await sut.register(withCredentials: credentials)
        
        //THEN
        XCTAssertTrue(mockAuthService.isRegisterCalled)
        XCTAssertTrue(mockUserService.isFetchUserCalled)
        XCTAssertTrue(mockCoordinator.isDidFinishWithAuth)
    }
    
    func test_register_givenInvalidCredentials_thenFail() async {
        //GIVEN
        let password = "invalidPassword"
        let credentials = AuthCredentials(email: mockUser.email,
                                          password: password,
                                          fullname: mockUser.fullname,
                                          username: mockUser.username)
        mockAuthService.registerResult = .failure(MockError.someError)
        mockAuthService.registerShouldFail = true
        
        //WHEN
        await sut.register(withCredentials: credentials)
        
        //THEN
        XCTAssertTrue(mockAuthService.isRegisterCalled)
        XCTAssertFalse(mockUserService.isFetchUserCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }

}
