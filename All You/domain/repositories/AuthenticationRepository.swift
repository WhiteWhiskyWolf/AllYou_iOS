//
//  AuthenticationRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-19.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn

class AuthenticationRepository {
    
    func getUserId() async -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func isSignedIn() -> AsyncStream<Bool> {
        AsyncStream(Bool.self) { cont in
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    cont.yield(true)
                } else {
                    cont.yield(false)
                }
            }
        }
    }
    
    @MainActor
    func signInWithGoogle() async -> Bool {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return false }
                
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
                
        GIDSignIn.sharedInstance.configuration = config
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            do {
                let result = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
                print("Restoring previous session")
                await authenticateGoogleUser(for: result)
                return true
            }
            catch {
                return false
            }
        } else {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return false }
            
            do {
                let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                await authenticateGoogleUser(for: result.user)
                return true
            }
            catch {
                print(error.localizedDescription)
                return false
            }
        }
    }
    
    @MainActor
    func authenticateGoogleUser(for user: GIDGoogleUser?) async {
        
        guard let idToken = user?.idToken?.tokenString else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user?.accessToken.tokenString ?? "")
        
        do {
            try await Auth.auth().signIn(with: credential)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
