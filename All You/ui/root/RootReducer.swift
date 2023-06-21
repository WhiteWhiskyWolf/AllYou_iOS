//
//  RootReducer.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-21.
//

import Foundation

struct RootReducer {
    func reduce(state: RootState, action: RootActions) -> RootState {
        switch(action) {
        case .CheckAuth: do {
            return state
        }
        case .AuthStatus(let isLoggedIn, let completedOnboarding):
            if (!isLoggedIn) {
                return RootState.logIn
            } else if (!completedOnboarding) {
                return RootState.onboarding
            } else {
                return RootState.loggedIn
            }
        }
    }
}
