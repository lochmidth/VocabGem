//
//  TabBarViewModelTests.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import XCTest
@testable import VocabGem

@MainActor
final class TabBarViewModelTests: XCTestCase {

    var mockCoordinator: MockTabBarCoordinator!
    var mockUserService: MockUserService!
//    var mockAuth: MockAuth!
    var sut: TabBarViewModel!

    override func setUpWithError() throws {
        mockCoordinator = MockTabBarCoordinator()
        mockUserService = MockUserService()
//        mockAuth = (MockAuth.auth() as! MockAuth)
        sut = TabBarViewModel(userService: mockUserService)
        sut.coordinator = mockCoordinator
    }

    func test_handleSignOut_shouldSuccess() async {
        //GIVEN

        //WHEN
        await sut.handleSignOut()

        //THEN
        XCTAssertTrue(mockCoordinator.isSignOutCalled)
    }

    func test_handleSignOut_shouldFail() async {
        //GIVEN
        mockCoordinator.signOutShouldFail = true

        //WHEN
        await sut.handleSignOut()

        //THEN
        XCTAssertTrue(mockCoordinator.isSignOutCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }

}
