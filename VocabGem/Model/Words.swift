//
//  Words.swift
//  VocabGem
//
//  Created by Alphan Ogün on 30.12.2023.
//

import Foundation

// MARK: - Words
struct Words: Codable {
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let total: Int
    let data: [String]
}
