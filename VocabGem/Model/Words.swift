//
//  Words.swift
//  VocabGem
//
//  Created by Alphan Ogün on 30.12.2023.
//

import Foundation

// MARK: - Words
struct Words: Codable {
    var results: Results
}

// MARK: - Results
struct Results: Codable {
    var total: Int
    var data: [String]
}
