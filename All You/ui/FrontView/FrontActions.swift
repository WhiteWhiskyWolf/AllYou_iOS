//
//  FrontActions.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-01.
//

import Foundation

enum FrontActions {
    case LoadCurrentUser
    case LoadMoreOtherAlters
    case LoadedSystem(
        searchString: String,
        isCurrentUser: Bool,
        selectedSystem: UserUIModel,
        alters: [AlterUIModel]
    )
    case SetAlters(
        alters: [AlterUIModel]
    )
    case LoadFriend(userId: String)
    case SetAlterAsFront(alterId: String)
    case ReplaceAlterAsFront(alterId: String)
    case RemoveAlterFromFront(alterId: String)
    case SearchAlter(searchString: String)
    case SelectAlter(alterId: String)
    case CloseAlter
}
