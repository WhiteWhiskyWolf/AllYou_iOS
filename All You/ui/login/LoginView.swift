//
//  LoginView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-24.
//

import SwiftUI
import CryptoKit
import AuthenticationServices
import FirebaseAuth
import os
import Firebase
import GoogleSignIn

struct LoginView: View {
    @ObservedObject private var store: Store<LoginState, LoginActions>
    
    init(onSignInSuccess: @escaping () -> Void) {
        self.store = Store(
            initialAction: nil,
            initialState: LoginState.Loaded,
            reducer: LoginReducer().reduce,
            sideEffects: LoginSideEffects(onSucessSignIn: onSignInSuccess).sideEffects()
        )
    }
    var body: some View {
        LoginView_Internal(state: store.state, dispatch: store.dispatch)
    }
}

private struct LoginView_Internal: View {
    var state: LoginState
    var dispatch: Dispatch<LoginActions>
    private let logger = Logger(subsystem: "LoginView", category: "foreground")
    
    @State private var currentNonce: String? = nil
    
    var body: some View {
        VStack {
            Spacer()
            Text("All You")
                .foregroundColor(Color.onBackground)
            Spacer()
            
            DynamicAppleSignIn(
                onRequest: { request in
                    let nonce = randomNonceString()
                    currentNonce = nonce
                    request.requestedScopes = [.fullName, .email]
                    request.nonce = sha256(nonce)
                },
                onCompletion: { result in
                    onSignInWithAppleResponse(result: result)
                }
            )
            
            Spacer()
                .oneVertical()
            Button(
                action: {dispatch(LoginActions.SignInWithGoogle)},
                label: {Text("Sign in with Google")}
            )
            .buttonStyle(PrimaryButton())
        }
        .background(Color.background)
        .padding()
    }
    
    private func onSignInWithAppleResponse(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    logger.error("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if (error != nil) {
                        logger.error("Unable to sign in: \(error!.localizedDescription)")
                        return
                    }
                }
            default:
                break
                
            }
        default:
            break
        }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.performRequests()
    }
}

struct DynamicAppleSignIn : View {
    @Environment(\.colorScheme) var colorScheme
    
    var onRequest: (ASAuthorizationAppleIDRequest) -> Void
    var onCompletion: ((Result<ASAuthorization, Error>) -> Void)
    
    var body: some View {
        
        switch colorScheme {
        case .dark:
            SignInWithAppleButton(
                onRequest: onRequest,
                onCompletion: onCompletion
            ).signInWithAppleButtonStyle(.white)
                .frame(minWidth: 140, maxWidth: .infinity, minHeight: 30,  maxHeight: 60, alignment: .center)
        case .light:
            SignInWithAppleButton(
                onRequest: onRequest,
                onCompletion: onCompletion
            ).signInWithAppleButtonStyle(.black)
                .frame(minWidth: 140, maxWidth: .infinity, minHeight: 30,  maxHeight: 60, alignment: .center)
        @unknown default:
            fatalError("Not Yet Implemented")
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            LoginView_Internal(state: .Loaded, dispatch: { _ in})
                .preferredColorScheme($0)
        }
    }
}
