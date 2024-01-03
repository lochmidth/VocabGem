//
//  HomeViewModelTests.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 3.01.2024.
//

import XCTest
@testable import VocabGem

@MainActor
final class HomeViewModelTests: XCTestCase {

    var mockCoordinator: MockTabBarCoordinator!
    var mockUserService: MockUserService!
    var mockWordsService: MockWordsService!
    var sut: HomeViewModel!
    
    override func setUpWithError() throws {
        mockCoordinator = MockTabBarCoordinator()
        mockUserService = MockUserService()
        mockWordsService = MockWordsService()
        sut = HomeViewModel(userService: mockUserService, wordsService: mockWordsService, user: mockUser)
        sut.coordinator = mockCoordinator
    }
    
    func test_greetingText() {
        //GIVEN
        sut.user = mockUser
        
        //WHEN
        let text = sut.greetingText
        
        //THEN
        XCTAssertEqual(text, "Welcome, mockuser!")
    }
    
    func test_searchWords_givenValidLetterPattern_thenSuccessWithWords() async {
        //GIVEN
        let letterPattern = "Apple"
        mockWordsService.searchWordsResult = .success(mockWords)
        
        //WHEN
        await sut.searchWords(letterPattern: letterPattern)
        
        //THEN
        XCTAssertTrue(mockWordsService.isSearchWordsCalled)
        XCTAssertEqual(sut.words?.results.data.count, 5)
    }
    
    func test_searchWords_givenError_thenFailWithMessage() async {
        //GIVEN
        let letterPattern = "Error!"
        mockWordsService.searchWordsResult = .failure(MockError.someError)
        
        //WHEN
        await sut.searchWords(letterPattern: letterPattern)
        
        //THEN
        XCTAssertTrue(mockWordsService.isSearchWordsCalled)
        XCTAssertNil(sut.words?.results.data.count)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
    
    func test_searchWords_givenEmptyLetter_thenSuccessWithEmptyWords() async {
        //GIVEN
        let letterPattern = ""
        mockWordsService.searchWordsResult = .success(mockWords)

        //WHEN
        await sut.searchWords(letterPattern: letterPattern)

        //THEN
        XCTAssertNil(sut.words?.results.data.count)
        XCTAssertFalse(mockWordsService.isSearchWordsCalled)
        XCTAssertFalse(mockCoordinator.isShowMessageCalled)
    }
    
    func test_fetchRecentWords_givenNothing_thenSuccessWithWords() async {
        //GIVEN
        mockWordsService.fetchRecentWordsResult = .success(mockWords.results.data)
        
        //WHEN
        await sut.fetchRecentWords()
        
        //THEN
        XCTAssertTrue(mockWordsService.isFetchRecentWordsCalled)
        XCTAssertEqual(sut.recentWords.count, 5)
    }
    
    func test_fetchRecentWords_givenError_thenFail() async {
        //GIVEN
        mockWordsService.fetchRecentWordsResult = .failure(MockError.someError)
        
        //WHEN
        await sut.fetchRecentWords()
        
        //THEN
        XCTAssertTrue(mockWordsService.isFetchRecentWordsCalled)
        XCTAssertEqual(sut.recentWords.count, 0)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
    
    func test_titleForHeaderInSection_givenNilWords_thenReturnString() {
        //GIVEN
        sut.words = nil
        
        //WHEN
        let title = sut.titleForHeaderInSection()
        
        //THEN
        XCTAssertEqual(title, "Recent Words")
    }
    
    func test_titleForHeaderInSection_givenEmptyWords_thenReturnString() {
        //GIVEN
        sut.words = mockEmptyWords
        
        //WHEN
        let title = sut.titleForHeaderInSection()
        
        //THEN
        XCTAssertEqual(title, "Recent Words")
    }
    
    func test_titleForHeaderInSection_givenWords_thenReturnString() {
        //GIVEN
        sut.words = mockWords
        
        //WHEN
        let title = sut.titleForHeaderInSection()
        
        //THEN
        XCTAssertEqual(title, "Search Results")
    }
    
    func test_numberOfRowsInSection_givenNilWords_thenReturnInt() {
        //GIVEN
        sut.words = nil
        sut.recentWords = mockWords.results.data
        
        //WHEN
        let numberOfRows = sut.numberOfRowsInSection()
        
        //THEN
        XCTAssertEqual(numberOfRows, 5)
    }
    
    func test_numberOfRowsInSection_givenEmptyWords_thenReturnInt() {
        //GIVEN
        sut.words = mockEmptyWords
        sut.recentWords = mockWords.results.data
        
        //WHEN
        let numberOfRows = sut.numberOfRowsInSection()
        
        //THEN
        XCTAssertEqual(numberOfRows, 5)
    }
    
    func test_numberOfRowsInSection_givenWords_thenReturnInt() {
        //GIVEN
        sut.words = mockWords
        
        //WHEN
        let numberOfRows = sut.numberOfRowsInSection()
        
        //THEN
        XCTAssertEqual(numberOfRows, 5)
    }
    
    func test_determineRecentsOrSearch_givenNilWords_thenReturnString() {
        //GIVEN
        sut.words = nil
        sut.recentWords = mockWords.results.data
        
        //WHEN
        let string = sut.determineRecentsOrSearch(atIndex: 0)
        
        //THEN
        XCTAssertEqual(string, "Apple")
    }
    
    func test_determineRecentsOrSerch_givenEmptyWords_thenReturnString() {
        //GIVEN
        sut.words = mockEmptyWords
        sut.recentWords = mockWords.results.data
        
        //WHEN
        let string = sut.determineRecentsOrSearch(atIndex: 1)
        
        //THEN
        XCTAssertEqual(string, "Banana")
    }
    
    func test_determineRecentsOrSearch_givenWords_thenReturnString() {
        //GIVEN
        sut.words = mockWords
        
        //WHEN
        let string = sut.determineRecentsOrSearch(atIndex: 2)
        
        //THEN
        XCTAssertEqual(string, "Orange")
    }
    
    func test_didSelectRowAt_givenNilWords_goToWordWithRecentWord() async {
        //GIVEN
        sut.words = nil
        sut.recentWords = mockWords.results.data
        mockWordsService.getWordsDetailsResult = .success(mockWord)
        mockWordsService.saveToRecentsResult = .success(true)
        
        //WHEN
        await sut.didSelectRowAt(index: 0)
        
        //THEN
        XCTAssertTrue(mockWordsService.isGetWordDetailsCalled)
        XCTAssertTrue(mockWordsService.isSaveToRecentsCalled)
        XCTAssertTrue(mockCoordinator.isGoToWordCalled)
    }
    
    func test_didSelectRowAt_givenEmptyWords_thenGoToWordsWithRecentWord() async {
        //GIVEN
        sut.words = mockEmptyWords
        sut.recentWords = mockWords.results.data
        mockWordsService.getWordsDetailsResult = .success(mockWord)
        mockWordsService.saveToRecentsResult = .success(true)
        
        //WHEN
        await sut.didSelectRowAt(index: 0)
        
        //THEN
        XCTAssertTrue(mockWordsService.isGetWordDetailsCalled)
        XCTAssertTrue(mockWordsService.isSaveToRecentsCalled)
        XCTAssertTrue(mockCoordinator.isGoToWordCalled)
    }
    
    func test_didSelectRowAt_givenWords_thenGoToWordWithWord() async {
        //GIVEN
        sut.words = mockWords
        mockWordsService.getWordsDetailsResult = .success(mockWord)
        mockWordsService.saveToRecentsResult = .success(true)
        
        //WHEN
        await sut.didSelectRowAt(index: 0)
        
        //THEN
        XCTAssertTrue(mockWordsService.isGetWordDetailsCalled)
        XCTAssertTrue(mockWordsService.isSaveToRecentsCalled)
        XCTAssertTrue(mockCoordinator.isGoToWordCalled)
    }
    
    func test_didSelectRowAt_givenWordsButFetchError_thenFail() async {
        //GIVEN
        sut.words = mockWords
        mockWordsService.getWordsDetailsResult = .failure(MockError.someError)
        mockWordsService.saveToRecentsResult = .success(true)
        
        //WHEN
        await sut.didSelectRowAt(index: 0)
        
        //THEN
        XCTAssertTrue(mockWordsService.isGetWordDetailsCalled)
        XCTAssertFalse(mockWordsService.isSaveToRecentsCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
    
    func test_didSelectRowAt_givenWordsButDatabaseError_thenFail() async {
        //GIVEN
        sut.words = mockWords
        mockWordsService.getWordsDetailsResult = .success(mockWord)
        mockWordsService.saveToRecentsResult = .failure(MockError.someError)
        
        //WHEN
        await sut.didSelectRowAt(index: 0)
        
        //THEN
        XCTAssertTrue(mockWordsService.isGetWordDetailsCalled)
        XCTAssertTrue(mockWordsService.isSaveToRecentsCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
    
    func test_clearRecentsButtonVisibility_givenRecentWords_thenReturnFalse() {
        //GIVEN
        sut.recentWords = mockWords.results.data
        
        //WHEN
        let visibility = sut.clearRecentsButtonVisibility()
        
        //THEN
        XCTAssertFalse(visibility)
    }
    
    func test_clearRecentsButtonVisibility_givenEmptyRecentWords_thenReturnTrue() {
        //GIVEN
        sut.recentWords = mockEmptyWords.results.data
        
        //WHEN
        let visibility = sut.clearRecentsButtonVisibility()
        
        //THEN
        XCTAssertTrue(visibility)
    }
    
    func test_clearRecentWords_givenRecentWords_thenSuccess() async {
        //GIVEN
        sut.recentWords = mockWords.results.data
        mockWordsService.clearRecentsWordsResult = .success(true)
        
        //WHEN
        await sut.clearRecentWords()
        
        //THEN
        XCTAssertTrue(mockWordsService.isClearRecentsWordsCalled)
        XCTAssertEqual(sut.recentWords.count, 0)
    }
    
    func test_clearRecentWords_givenNetworkError_thenFail() async {
        //GIVEN
        sut.recentWords = mockWords.results.data
        mockWordsService.clearRecentsWordsResult = .failure(MockError.someError)
        
        //WHEN
        await sut.clearRecentWords()
        
        //THEN
        XCTAssertTrue(mockWordsService.isClearRecentsWordsCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
        XCTAssertEqual(sut.recentWords.count, 5)
    }

}
