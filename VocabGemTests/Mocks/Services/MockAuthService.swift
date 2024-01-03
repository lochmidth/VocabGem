//
//  MockAuthService.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import Foundation
@testable import VocabGem

class MockAuthService: AuthServicing {
    
    var loginResult: Result<Bool, Error>?
    var isLoginCalled = false
    var loginShouldFail = false
    func login(withEmail email: String, password: String) async throws {
        isLoginCalled = true
        
        if loginShouldFail {
            throw MockError.someError
        }
        
        if let loginResult = loginResult {
            switch loginResult {
            case .success:
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
        
        
    }
    
    var registerResult: Result<Bool, Error>?
    var isRegisterCalled = false
    var registerShouldFail = false
    func register(withCredentials credentials: VocabGem.AuthCredentials) async throws {
        isRegisterCalled = true
        
        if registerShouldFail {
            throw MockError.someError
        }
        
        if let registerResult = registerResult {
            switch registerResult {
            case .success:
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    
}
