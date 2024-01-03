//
//  WordViewModelTests.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 4.01.2024.
//

import XCTest
import AVFoundation
@testable import VocabGem

@MainActor
final class WordViewModelTests: XCTestCase {
    
    var mockCoordinator: MockTabBarCoordinator!
    var sut: WordViewModel!
    
    override func setUpWithError() throws {
        mockCoordinator = MockTabBarCoordinator()
        sut = WordViewModel(word: mockWord)
        sut.coordinator = mockCoordinator
    }
    
    func test_wordText() {
        let word = sut.wordText
        
        XCTAssertEqual(word, "Apple")
    }
    
    func test_partOfSpeechText() {
        let partOfSpeech = sut.partOfSpeechText
        
        XCTAssertEqual(partOfSpeech, "Noun")
    }
    
    func test_definitionText() {
        let definition = sut.definitionText
        
        XCTAssertEqual(definition, "The round fruit of a tree of the rose family, which typically has thin red or green skin and crisp flesh.")
    }
    
    func test_exampleText() {
        let example = sut.exampleText
        
        XCTAssertEqual(example, "Example:\n I had an apple for a snack.")
    }
    
    func test_synonymsText() {
        let synonyms = sut.synonymsText
        
        XCTAssertEqual(synonyms, "Synonyms:\n Fruit"  )
    }
    
    func test_textToSpeech() {
        let utterance = AVSpeechUtterance(string: "Example for Unit Test")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        
        sut.synthesizer.speak(utterance)
    }
}
