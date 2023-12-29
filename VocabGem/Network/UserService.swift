//
//  UserService.swift
//  VocabGem
//
//  Created by Alphan Ogün on 28.12.2023.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserService {
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot, error in
            guard let dictionary = snapshot.value else { return }
            let user = User(uid: uid, dictionary: dictionary as! [String : Any])
            completion(user)
        }
    }
}
