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
    case ViewError
}

class GoogleService {
    
    func signInWithGoogle() async throws -> User {
        guard let clientID = FirebaseApp.app()?.options.clientID else { throw GoogleError.invalidClientID }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else { throw GoogleError.ViewError }
        
        do {
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
        } catch {
            throw error
        }
    }
}
