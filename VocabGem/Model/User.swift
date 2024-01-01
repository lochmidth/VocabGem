//
//  User.swift
//  VocabGem
//
//  Created by Alphan Ogün on 28.12.2023.
//

import UIKit

struct User {
    let email: String
    var fullname: String
    var username: String
    var score: Int
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.score = dictionary["score"] as? Int ?? 0
    }
}
