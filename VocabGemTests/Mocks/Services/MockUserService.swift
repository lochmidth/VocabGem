//
//  MockUserService.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import Foundation
@testable import VocabGem

enum MockError: Error {
    case someError
}

class MockUserService: UserServicing {

    var isLoggedIn: Bool?
    var isCheckIfUserIsLoggedInCalled = false
    
    func checkIfUserIsLoggedIn() -> Bool {
        isCheckIfUserIsLoggedInCalled = true
        if let isLoggedIn = isLoggedIn {
            return isLoggedIn
        } else {
            return false
        }
    }
    
    var fetchUserResult: Result<User, Error>?
    var isFetchUserCalled = false

    func fetchUser() async throws -> User {
        isFetchUserCalled = true
        
        if let fetchUserResult = fetchUserResult {
            switch fetchUserResult {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }


}
