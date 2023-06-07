//
//  OnboardingReducer.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation


struct OnboardingReducer {
    let reducer: Reducer<OnboardingState, OnboardingActions> = { state, action in
        switch(action) {
        case OnboardingActions.NavigateToNextPage:
            if (state.page < 4) { // number of pages
                return state.copy(page: state.page + 1)
            } else {
                return state
            }
        case .NavigateToPreviousPage:
            if (state.page == 0) {
                return state
            } else {
                return state.copy(page: state.page - 1)
            }
        case .DisplaySelectColor:
            return state.copy(displaySelectColor: true)
        case .HideSelectColor:
            return state.copy(displaySelectColor: false)
        case .DisplaySelectPhoto:
            return state.copy(displaySelectPhoto: true)
        case .HidSelectPhoto:
            return state.copy(displaySelectPhoto: false)
        case .UpdateSystemName(newName: let newName):
            return state.copy(systemName: newName)
        case .UpdateSystemPronounts(newPronouns: let newPronouns):
            return state.copy(systemPronouns: newPronouns)
        case .UpateSystemColor(newColor: let newColor):
            return state.copy(systemColor: newColor)
        case .SelectNewSystemProfilePhoto:
            return state.copy(displaySelectPhoto: true)
        case .UpdateSystemProfilePhoto(newId: let newPhoto):
            return state.copy(systemImage: newPhoto)
        case .IsSignlet:
            return state.copy(page: (state.page + 1), isSignlet: true)
        case .UpdateAltername(newName: let newName):
            return state.copy(alterName: newName)
        case .UpdateAlterPronouns(newPronouns: let newPronouns):
            return state.copy(alterPronouns: newPronouns)
        case .UpdateAlterDescription(newDescription: let newDescription):
            return state.copy(alterDescription: newDescription)
        case .UpdateAlterColor(newColor: let newColor):
            return state.copy(alterColor: newColor)
        case .UpdateAlterRole(newRole: let newRole):
            return state.copy(alterRole: newRole)
        case .UpdateAlterProfilePhoto(newPhoto: let newPhoto):
            return state.copy(alterImage: newPhoto)
        case .SaveProfile:
            return state
        }
    }
}
