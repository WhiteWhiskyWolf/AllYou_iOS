//
//  LoginSideEffects.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-24.
//

import Foundation


struct LoginSideEffects {
    @Service var signInWithAppleUseCase: SignInWithAppleUseCase
    @Service var signInWithGoogleUseCase: SignInWithGoogleUseCase
    
    let onSucessSignIn: () -> Void
    
    init( onSucessSignIn: @escaping () -> Void) {
        self.onSucessSignIn = onSucessSignIn
    }
    
    func sideEffects() -> [SideEffect<LoginState, LoginActions>]  {
        return [
            onSignInSuccess,
            onSignInWithApple,
            onSignInWithGoogle
        ]
    }
    
    private func onSignInSuccess(oldState: LoginState, newState: LoginState, action: LoginActions, dispatch: Dispatch<LoginActions>) {
        if (.SuccessfulSignIn == action) {
            onSucessSignIn()
        }
    }
    
    private func onSignInWithApple(oldState: LoginState, newState: LoginState, action: LoginActions, dispatch: Dispatch<LoginActions>) async {
        if (.SignInWithApple == action) {
            _ = await signInWithAppleUseCase.invoke()
        }
    }
    
    private func onSignInWithGoogle(oldState: LoginState, newState: LoginState, action: LoginActions, dispatch: Dispatch<LoginActions>) async {
        if (.SignInWithGoogle == action) {
            _ = await signInWithGoogleUseCase.invoke()
        }
    }
}
