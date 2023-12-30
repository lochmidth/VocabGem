//
//  Word.swift
//  VocabGem
//
//  Created by Alphan Ogün on 30.12.2023.
//

import Foundation

// MARK: - Word
struct Word: Codable {
    let word: String
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let definition: String
    let partOfSpeech: String
    let synonyms: [String]?
    let examples: [String]?
}
