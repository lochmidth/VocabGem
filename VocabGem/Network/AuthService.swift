//
//  AuthService.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    case loginError
    case registerError
}

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
}

class AuthService {
    
    func login(withEmail email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            print("\(Auth.auth().currentUser?.email) is logged in.")
        } catch {
            throw error
        }
    }
    
    func register(withCredentials credentials: AuthCredentials) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: credentials.email, password: credentials.password)
            let uid = result.user.uid
            
            let values = ["email": credentials.email,
                          "username": credentials.username,
                          "fullname": credentials.fullname]
            
            try await REF_USERS.child(uid).updateChildValues(values)
        } catch {
            throw error
        }
    }
}
