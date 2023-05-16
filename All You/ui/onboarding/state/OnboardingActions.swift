//
//  OnboardingActions.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation

enum OnboardingActions {
    case NavigateToNextPage
    case NavigateToPreviousPage
    case DisplaySelectColor
    case HideSelectColor
    case DisplaySelectPhoto
    case HidSelectPhoto
    
    case UpdateSystemName(newName: String)
    case UpdateSystemPronounts(newPronouns: String)
    case UpateSystemColor(newColor: String)
    case SelectNewSystemProfilePhoto
    case UpdateSystemProfilePhoto(newPhoto: Data)
    
    case IsSignlet
    
    case UpdateAltername(newName: String)
    case UpdateAlterPronouns(newPronouns: String)
    case UpdateAlterDescription(newDescription: String)
    case UpdateAlterColor(newColor: String)
    case UpdateAlterRole(newRole: String)
    case UpdateAlterProfilePhoto(newPhoto: Data)
    
    case SaveProfile
}
