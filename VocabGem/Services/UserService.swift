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

class UserService {
    
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
    
//    func fetchUser(completion: @escaping(User) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot, error in
//            guard let dictionary = snapshot.value else { return }
//            let user = User(uid: uid, dictionary: dictionary as! [String : Any])
//            completion(user)
//        }
//    }
}
