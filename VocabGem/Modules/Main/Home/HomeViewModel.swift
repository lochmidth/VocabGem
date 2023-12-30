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
    var recentWords = [String]()
    
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
        if letterPattern.isEmpty {
            words?.results.data.removeAll()
        } else {
            Task {
                do {
                    self.words = try await wordsService.searchWords(letterPattern: letterPattern)
                } catch {
                    print("DEBUG: Error while bulk searching the word: \(letterPattern), \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getWordDetails(word: String) {
        Task {
            do {
                self.wordDetail = try await wordsService.getWordDetails(word: word)
                try await saveToRecents(word: word)
                guard let wordDetail = wordDetail else { return }
                await MainActor.run(body: {
                    self.coordinator?.goToWord(word: wordDetail)
                })
            } catch {
                print("DEBUG: Error while getting the word: \(word), \(error.localizedDescription)")
            }
        }
    }
    
    private func saveToRecents(word: String) async throws {
        do {
            try await wordsService.saveToRecents(word: word)
        } catch {
            print("DEBUG: Error while saving \(word) to recents, \(error.localizedDescription)")
        }
    }
    
    func fetchRecentWords() async throws {
            do {
                self.recentWords = try await wordsService.fetchRecentWords()
            } catch {
                print("DEBUG: Error while fetching recent words, \(error.localizedDescription)")
        }
    }
    
    func titleForHeaderInSection() -> String? {
        if let words = words {
            if words.results.data.isEmpty {
                return "Recent Words"
            } else {
                return "Search Results"
            }
        }
        return "Recent Words"
    }
    
    func numberOfRowsInSection() -> Int {
        if let words = words {
            if words.results.data.isEmpty {
                return recentWords.count
            } else {
                return words.results.data.count
            }
        }
        return recentWords.count
    }
    
    func determineRecentsOrSearch(atIndex index: Int) -> String {
        if let words = words {
            if words.results.data.isEmpty {
                return recentWords[index]
            } else {
                return words.results.data[index]
            }
        }
        return recentWords[index]
    }
    
    func didSelectRowAt(index: Int) {
        if let words = words {
            if words.results.data.isEmpty {
                getWordDetails(word: recentWords[index])
                return
            } else {
                getWordDetails(word: words.results.data[index])
                return
            }
        }
        getWordDetails(word: recentWords[index])
        return
    }
    
    func clearRecentsButtonVisibility() -> Bool {
        if !recentWords.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func clearRecentWords() async throws {
        do {
            try await wordsService.clearRecentWords()
            recentWords.removeAll()
        } catch {
            print("DEBUG: Error while clearing the recent words, \(error.localizedDescription)")
        }
    }
}
