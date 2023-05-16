//
//  LoginReducer.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-24.
//

import Foundation


struct LoginReducer {
    let reduce: Reducer<LoginState, LoginActions> = { state, _ in
        // Empty reducer since Login page holds no state
        return state
    }
}
