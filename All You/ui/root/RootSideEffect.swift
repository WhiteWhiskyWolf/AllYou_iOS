//
//  RootSideEffect.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-21.
//

import Foundation

struct RootSideEffects {
    @Service var isUserSignedInUseCase: IsUserSignedInUseCase
    @Service var hasUseCompletedOnboardingUseCase: HasUseCompletedOnboardingUseCase
    
    func sideEffects() -> [SideEffect<RootState, RootActions>] {
        return [
            checkAuthSideEffect
        ]
    }
    
    private func checkAuthSideEffect(oldState: RootState, newState: RootState, action: RootActions, dispatch: Dispatch<RootActions>) async {
        if case .CheckAuth = action {
            let signedIn = await isUserSignedInUseCase.invoke()
            let completedOnboarding = await hasUseCompletedOnboardingUseCase.invoke()
            dispatch(RootActions.AuthStatus(isSignedIn: signedIn, comletedOnboarding: completedOnboarding))
        }
    }
}
