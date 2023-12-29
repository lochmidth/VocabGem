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
    let pronunciation: Pronunciation
}

// MARK: - Pronunciation
struct Pronunciation: Codable {
    let all: String
}

// MARK: - Result
struct Result: Codable {
    let definition: String
    let partOfSpeech: String
    let synonyms: [String]?
    let examples: [String]?
}

//enum PartOfSpeech: String, Codable {
//    case noun = "noun"
//    case verb = "verb"
//}
