//
//  HomeViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation

class homeViewModel {
    //MARK: - Properties
    
    weak var coordinator: TabBarCoordinator?
    let userService: UserService
    let wordsService: WordsService
    var user: User
    var wordDetail: Word?
    var words: Words?
    
    var greetingText: String {
        "Welcome, \(user.username)!"
    }
    
    //MARK - Lifecycle
    
    init(userService: UserService = UserService(), wordsService: WordsService = WordsService(), user: User) {
        self.userService = userService
        self.wordsService = wordsService
        self.user = user
    }
    
    //MARK: - Helpers
        
//    func didTapSearchButton(withWord word: String) {
//        print("DEBUG: Searched word is \(word)")
//        coordinator?.goToWord()
//    }
    
    func searchWords(letterPattern: String) {
        Task {
            do {
                self.words = try await wordsService.searchWords(letterPattern: letterPattern)
            } catch {
                print("DEBUG: Error while bulk searching the word: \(letterPattern), \(error.localizedDescription)")
            }
        }
    }
    
    func getWordDetails(word: String) {
        Task {
            do {
                self.wordDetail = try await wordsService.getWordDetails(word: word)
                guard let wordDetail = wordDetail else { return }
                await MainActor.run(body: {
                    self.coordinator?.goToWord(word: wordDetail)
                })
            } catch {
                print("DEBUG: Error while getting the word: \(word), \(error.localizedDescription)")
            }
        }
    }
}
