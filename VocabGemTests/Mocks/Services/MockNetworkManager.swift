//
//  MockNetworkManager.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import Foundation
import Moya
@testable import VocabGem

class MockNetworkManager: NetworkManaging {
    
    var result: Result<Any, Error>?
    
    var isRequestCalled = false
    func request<T: Codable>(_ target: Moya.TargetType) async throws -> T {
        isRequestCalled = true
        
        if let result = result {
            switch result {
            case .success(let value as T):
                return value
            case .failure(let error):
                throw error
            default:
                throw MockError.someError
            }
        } else {
            throw MockError.someError
        }
    }
}
