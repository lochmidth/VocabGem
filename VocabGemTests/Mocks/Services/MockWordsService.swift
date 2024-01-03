//
//  MockWordsService.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import Foundation
@testable import VocabGem

class MockWordsService: WordsServicing {
    
    var searchWordsResult: Result<Words, Error>?
    var isSearchWordsCalled = false
    
    func searchWords(letterPattern: String) async throws -> VocabGem.Words {
        isSearchWordsCalled = true
        
        if let searchWordsResult = searchWordsResult {
            switch searchWordsResult {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var getWordsDetailsResult: Result<Word, Error>?
    var isGetWordDetailsCalled = false
    
    func getWordDetails(word: String) async throws -> VocabGem.Word {
        isGetWordDetailsCalled = true
        
        if let getWordsDetailsResult = getWordsDetailsResult {
            switch getWordsDetailsResult {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var fetchRecentWordsResult: Result<[String], Error>?
    var isFetchRecentWordsCalled = false
    
    func fetchRecentWords() async throws -> [String] {
        isFetchRecentWordsCalled = true
        
        if let fetchRecentWordsResult = fetchRecentWordsResult {
            switch fetchRecentWordsResult {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var saveToRecentsResult: Result<Bool, Error>?
    var isSaveToRecentsCalled = false
    
    func saveToRecents(word: String) async throws {
        isSaveToRecentsCalled = true
        
        if let saveToRecentsResult = saveToRecentsResult {
            switch saveToRecentsResult {
            case .success:
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var clearRecentsWordsResult: Result<Bool, Error>?
    var isClearRecentsWordsCalled = false
    
    func clearRecentWords() async throws {
        isClearRecentsWordsCalled = true
        
        if let clearRecentsWordsResult = clearRecentsWordsResult {
            switch clearRecentsWordsResult {
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
