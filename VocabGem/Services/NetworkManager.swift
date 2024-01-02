//
//  NetworkManager.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation
import Moya

enum NetworkError: Error {
    case invlalidData
}

protocol NetworkManaging {
    func request<T: Codable>(_ target: TargetType) async throws -> T
}

class NetworkManager: NetworkManaging {
    private let provider: MoyaProvider<MultiTarget>
    private let decoder: JSONDecoder
    
    init(provider: MoyaProvider<MultiTarget> = MoyaProvider(), decoder: JSONDecoder = JSONDecoder()) {
        self.provider = provider
        self.decoder = decoder
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T: Codable>(_ target: TargetType) async throws -> T {
        return try await withCheckedThrowingContinuation({ continuation in
            provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let response):
                    do {
                        let value = try self.decoder.decode(T.self, from: response.data)
                        continuation.resume(with: .success(value))
                    } catch {
                        continuation.resume(with: .failure(error))
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        })
    }
}
