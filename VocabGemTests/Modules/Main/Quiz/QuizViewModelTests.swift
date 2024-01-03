//
//  QuizViewModelTests.swift
//  VocabGemTests
//
//  Created by Alphan Ogün on 4.01.2024.
//

import XCTest
@testable import VocabGem

@MainActor
final class QuizViewModelTests: XCTestCase {
    
    var mockCoordinator: MockTabBarCoordinator!
    var mockQuizManager: MockQuizManager!
    var sut: QuizViewModel!
    
    override func setUpWithError() throws {
        mockCoordinator = MockTabBarCoordinator()
        mockQuizManager = MockQuizManager()
        sut = QuizViewModel(user: mockUser, quizManager: mockQuizManager)
        sut.coordinator = mockCoordinator
    }
    
    func test_scoreText() {
        //GIVEN
//        mockQuizManager.fetchQuizesResult = .success([mockQuiz1, mockQuiz2])
        
        //WHEN
        let scoreText = sut.scoreText
        
        //THEN
        XCTAssertEqual(scoreText, "Score: 100")
    }
    

    func test_fetchQuizes_givenNothing_thenSuccess() async {
        //GIVEN
        mockQuizManager.fetchQuizesResult = .success([mockQuiz1, mockQuiz2])
        
        //WHEN
        await sut.fetchQuizes()
        
        //THEN
        XCTAssertTrue(mockQuizManager.isFetchQuizesCalled)
    }
    
    func test_fetchQuizes_givenNetworkError_thenFail() async {
        //GIVEN
        mockQuizManager.fetchQuizesResult = .failure(MockError.someError)
        
        //WHEN
        await sut.fetchQuizes()
        
        //THEN
        XCTAssertTrue(mockQuizManager.isFetchQuizesCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
    
    func test_updateScore_givenNothing_thenSuccess() async {
        //GIVEN
        mockQuizManager.updateScoreResult = .success(true)
        
        //WHEN
        await sut.updateScore()
        
        //THEN
        XCTAssertTrue(mockQuizManager.isUpdateScoreCalled)
    }
    
    func test_updateScore_givenNetworkError_thenFail() async {
        //GIVEN
        mockQuizManager.updateScoreResult = .failure(MockError.someError)
        
        //WHEN
        await sut.updateScore()
        
        //THEN
        XCTAssertTrue(mockQuizManager.isUpdateScoreCalled)
        XCTAssertTrue(mockCoordinator.isShowMessageCalled)
    }
}
