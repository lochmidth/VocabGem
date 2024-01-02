//
//  WordsService.swift
//  VocabGem
//
//  Created by Alphan Ogün on 30.12.2023.
//

import Foundation
import FirebaseAuth
import Moya

enum WordsError: Error {
    case invalidUid
}

class WordsService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func searchWords(letterPattern: String) async throws -> Words {
        let request = WordsAPI.searchWords(letterPatter: letterPattern.lowercased())
        return try await networkManager.request(request)
    }
    
    func getWordDetails(word: String) async throws -> Word {
        let request = WordsAPI.getWordDetails(word: word.lowercased())
        return try await networkManager.request(request)
    }
    
    func fetchRecentWords() async throws -> [String] {
        guard let uid = Auth.auth().currentUser?.uid else { throw WordsError.invalidUid }
        return await withCheckedContinuation { continuation in
            REF_RECENTS.child(uid).observeSingleEvent(of: .value, with: { snapshot in
                var recentWords = [String]()
                
                if let value = snapshot.value as? [String: Any],
                   let words = value["words"] as? [String] {
                    recentWords = words
                }
                continuation.resume(returning: recentWords)
            })
        }
    }
    
    func saveToRecents(word: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { throw WordsError.invalidUid }
        var recentWords = try await fetchRecentWords()
        
        if !recentWords.contains(word) {
            recentWords.append(word)
        }
        try await REF_RECENTS.child(uid).updateChildValues(["words": recentWords])
    }
    
    func clearRecentWords() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { throw WordsError.invalidUid }
        try await REF_RECENTS.child(uid).removeValue()
    }
}
