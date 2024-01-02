//
//  GoogleService.swift
//  VocabGem
//
//  Created by Alphan Ogün on 31.12.2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum GoogleError: Error {
    case invalidClientID
    case invalidIdToken
    case signInError
    case ViewError
}


protocol GoogleServicing {
    @MainActor func signInWithGoogle() async throws -> User
}

class GoogleService: GoogleServicing {
    
    @MainActor
    func signInWithGoogle() async throws -> User {
        guard let clientID = FirebaseApp.app()?.options.clientID else { throw GoogleError.invalidClientID }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else { throw GoogleError.ViewError }
        
        let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        let user = userAuthentication.user
        guard let idToken = user.idToken else { throw GoogleError.invalidIdToken}
        let accessToken = user.accessToken
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        let result = try await Auth.auth().signIn(with: credential)
        let uid = result.user.uid
        
        let dictionary = ["email": result.user.email,
                          "fullname": result.user.displayName,
                          "username": result.user.displayName]
        
        try await REF_USERS.child(uid).updateChildValues(dictionary as [AnyHashable : Any])
        
        let fetchedUser = User(uid: uid, dictionary: dictionary as [String : Any])
        return fetchedUser
    }
}
