//
//  Constants.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import Foundation
import FirebaseDatabase

//MARK: - Database

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_RECENTS = DB_REF.child("recents")
let REF_QUIZES = DB_REF.child("quizes")

//MARK: - WordsAPI

let wordsAPIKey = "0a88629ce4msh03be90628e82e14p1b0eb1jsnc40fc356a6a3"
let wordsAPIHost = "wordsapiv1.p.rapidapi.com"
