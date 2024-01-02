//
//  UserService.swift
//  VocabGem
//
//  Created by Alphan Ogün on 28.12.2023.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

enum UserError: Error {
    case fetchingError
}

protocol UserServicing {
    func checkIfUserIsLoggedIn() -> Bool
    func fetchUser() async throws -> User
}

class UserService: UserServicing {
    
    func checkIfUserIsLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        } else {
            return true
        }
    }
    
    func fetchUser() async throws -> User {
        guard let uid = Auth.auth().currentUser?.uid else { throw UserError.fetchingError }
        let (snapshot, _) = await REF_USERS.child(uid).observeSingleEventAndPreviousSiblingKey(of: .value)
        guard let dictionary = snapshot.value else { throw UserError.fetchingError }
        let user = User(uid: uid, dictionary: dictionary as! [String : Any])
        return user
    }
}
