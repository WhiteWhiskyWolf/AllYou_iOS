//
//  RootState.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-21.
//

import Foundation

enum RootState {
    case loading
    case logIn
    case onboarding
    case loggedIn
}

//struct RootState {
//    let isLoading: Bool
//    let isLoggedIn: Bool
//    let completedOnboarding: Bool
//    
//    init(isLoggedIn: Bool = false, completedOnboarding: Bool = false) {
//        
//        self.isLoggedIn = isLoggedIn
//        self.completedOnboarding = completedOnboarding
//    }
//    
//    func copy(isLoggedIn: Bool? = nil, completedOnboarding: Bool? = nil) -> RootState {
//        return RootState(
//            isLoggedIn: isLoggedIn ?? self.isLoggedIn,
//            completedOnboarding: completedOnboarding ?? self.completedOnboarding
//        )
//    }
//}
