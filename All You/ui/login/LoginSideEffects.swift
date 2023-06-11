//
//  LoginSideEffects.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-24.
//

import Foundation


struct LoginSideEffects {
    @Service var signInWithGoogleUseCase: SignInWithGoogleUseCase
    
    let onSucessSignIn: () -> Void
    
    init( onSucessSignIn: @escaping () -> Void) {
        self.onSucessSignIn = onSucessSignIn
    }
    
    func sideEffects() -> [SideEffect<LoginState, LoginActions>]  {
        return [
            onSignInSuccess,
            onSignInWithGoogle
        ]
    }
    
    private func onSignInSuccess(oldState: LoginState, newState: LoginState, action: LoginActions, dispatch: Dispatch<LoginActions>) {
        if (.SuccessfulSignIn == action) {
            onSucessSignIn()
        }
    }
    
    private func onSignInWithGoogle(oldState: LoginState, newState: LoginState, action: LoginActions, dispatch: Dispatch<LoginActions>) async {
        if (.SignInWithGoogle == action) {
            _ = await signInWithGoogleUseCase.invoke()
        }
    }
}
