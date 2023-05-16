//
//  OnboardingSideEffects.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation

class OnboardingSideEffects {
    let onSaveProfile: () -> Void
    @Service var saveOnboardingUserProfileUsecase: SaveOnboardingUserProfileUseCase
    
    init(onSaveProfile: @escaping () -> Void) {
        self.onSaveProfile = onSaveProfile
    }
    
    func sideEffects() -> [SideEffect<OnboardingState, OnboardingActions>] {
        return [
            onSaveProfile
        ]
    }
    
    private func onSaveProfile(
        oldState: OnboardingState,
        newState: OnboardingState,
        action: OnboardingActions,
        dispatch: Dispatch<OnboardingActions>
    ) async {
        if case OnboardingActions.SaveProfile = action {
            await saveOnboardingUserProfileUsecase.invoke(
                systemName: newState.systemName,
                systemPronouns: newState.systemPronouns,
                systemColor: newState.systemColor,
                systemImage: newState.systemImage,
                isSignlet: newState.isSignlet,
                alterName: newState.alterName,
                alterPronouns: newState.alterPronouns,
                alterColor: newState.alterColor,
                alterImage: newState.alterImage,
                alterDescription: newState.alterDescription,
                alterRole: newState.alterRole
            )
            onSaveProfile()
        }
    }
}
