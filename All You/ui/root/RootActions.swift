//
//  RootActions.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-21.
//

import Foundation

enum RootActions {
    case CheckAuth
    case AuthStatus(isSignedIn: Bool, comletedOnboarding: Bool)
}
