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

protocol AuthProtocol: AnyObject {
    func signOut() throws
}

class UserService: UserServicing {
    
    let auth: Auth
    
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }
    
    func checkIfUserIsLoggedIn() -> Bool {
        if auth.currentUser == nil {
            return false
        } else {
            return true
        }
    }
    
    func fetchUser() async throws -> User {
        guard let uid = auth.currentUser?.uid else { throw UserError.fetchingError }
        let (snapshot, _) = await REF_USERS.child(uid).observeSingleEventAndPreviousSiblingKey(of: .value)
        guard let dictionary = snapshot.value else { throw UserError.fetchingError }
        let user = User(uid: uid, dictionary: dictionary as! [String : Any])
        return user
    }
}
