//
//  MockGoogleService.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import Foundation
@testable import VocabGem

class MockGoogleService: GoogleServicing {
    
    var signInWithGoogleResult: Result<User, Error>?
    var isSignInWithGoogleCalled = false
    var signInWithGoogleShouldFail = false
    
    func signInWithGoogle() async throws -> VocabGem.User {
        isSignInWithGoogleCalled = true
        
        if signInWithGoogleShouldFail {
            throw MockError.someError
        }
        
        if let signInWithGoogleResult = signInWithGoogleResult {
            switch signInWithGoogleResult {
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
