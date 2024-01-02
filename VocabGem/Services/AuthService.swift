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

protocol AuthServicing {
    func login(withEmail email: String, password: String) async throws
    func register(withCredentials credentials: AuthCredentials) async throws
}

class AuthService: AuthServicing {
    
    let auth: Auth
    
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }
    
    func login(withEmail email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func register(withCredentials credentials: AuthCredentials) async throws {
        let result = try await Auth.auth().createUser(withEmail: credentials.email, password: credentials.password)
        let uid = result.user.uid
        
        let values = ["email": credentials.email,
                      "username": credentials.username,
                      "fullname": credentials.fullname]
        
        try await REF_USERS.child(uid).updateChildValues(values)
    }
}
