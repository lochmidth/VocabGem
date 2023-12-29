//
//  WordsService.swift
//  VocabGem
//
//  Created by Alphan Ogün on 30.12.2023.
//

import Foundation
import Moya

class WordsService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func searchWords(letterPattern: String) async throws -> Words {
        let request = WordsAPI.searchWords(letterPatter: letterPattern)
        do {
            return try await networkManager.request(request)
        } catch {
            throw error
        }
    }
    
    func getWordDetails(word: String) async throws -> Word {
        let request = WordsAPI.getWordDetails(word: word)
        do {
            return try await networkManager.request(request)
        } catch {
            throw error
        }
    }
}
