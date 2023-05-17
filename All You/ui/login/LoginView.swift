//
//  LoginView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-24.
//

import SwiftUI
import Appwrite

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
    
    var body: some View {
        VStack {
            Spacer()
            Text("All You")
                .foregroundColor(Color.onBackground)
            Spacer()
            Button(
                action: {dispatch(LoginActions.SignInWithApple)},
                label: {Text("Sign in with Apple")}
            )
            .buttonStyle(PrimaryButton())
            Spacer()
                .frame(maxHeight: 8)
            Button(
                action: {dispatch(LoginActions.SignInWithGoogle)},
                label: {Text("Sign in with Google")}
            )
            .buttonStyle(PrimaryButton())
        }
        .background(Color.background)
        .padding()
        .registerOAuthHandler()
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
