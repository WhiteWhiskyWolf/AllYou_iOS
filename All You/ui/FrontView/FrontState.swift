//
//  FrontState.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-01.
//

import Foundation

enum FrontState {
    case Loading
    case Loaded(
        searchString: String,
        isCurrentUser: Bool,
        selectedAlter: String?,
        selectedSystem: UserUIModel,
        alters: [AlterUIModel]
    )
}
