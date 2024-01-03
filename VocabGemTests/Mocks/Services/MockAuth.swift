////
////  MockAuth.swift
////  VocabGemTests
////
////  Created by Alphan Ogün on 3.01.2024.
////
//
//import Foundation
//import FirebaseAuth
//@testable import VocabGem
//
//class MockAuth: Auth {
//    
//    var isSignOutCalled = false
//    var signOutShouldFail = false
//    
//    override class func auth() -> Auth {
//        <#code#>
//    }
//    
//    override func signOut() throws {
//        isSignOutCalled = true
//        
//        if signOutShouldFail {
//            throw MockError.someError
//        }
//    }
//}
