//
//  WordViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation
import AVFoundation

class WordViewModel {
    
    //MARK: - Properties
    
    let synthesizer: AVSpeechSynthesizer
    weak var coordinator: TabBarCoordinating?
    let word: Word
    
    var wordText: String {
        word.word
    }
    
    var partOfSpeechText: String {
        word.results[0].partOfSpeech ?? ""
    }
    
    var definitionText: String {
        word.results[0].definition ?? "There is no definition available for this word"
    }
    
    var exampleText: String {
        "Example:\n \(word.results[0].examples?[0] ?? "There is no example available for this word")"
    }
    
    var synonymsText: String {
        "Synonyms:\n \(word.results[0].synonyms?[0] ?? "There is no synonyms available for this word")"
    }
    
    //MARK: - Lifecycle
    
    init(word: Word, synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()) {
        self.word = word
        self.synthesizer = synthesizer
    }
    
    //MARK: - Helpers
    
    func textToSpeech(word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        
        synthesizer.speak(utterance)
    }
    
}
