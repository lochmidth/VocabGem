//
//  Constants.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import Foundation
import FirebaseDatabase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_RECENTS = DB_REF.child("recents")
let REF_QUIZES = DB_REF.child("quizes")
