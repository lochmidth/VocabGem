//
//  UserService.swift
//  VocabGem
//
//  Created by Alphan Ogün on 28.12.2023.
//

import Foundation
import FirebaseDatabase

enum UserError: Error {
    case fethingError
}

class UserService {
    
    func fetchUser(withUid uid: String) async throws -> User {
        let (snapshot, _) = await REF_USERS.child(uid).observeSingleEventAndPreviousSiblingKey(of: .value)
        guard let dictionary = snapshot.value else { throw UserError.fethingError }
        let user = User(uid: uid, dictionary: dictionary as! [String : Any])
        return user
    }
}
