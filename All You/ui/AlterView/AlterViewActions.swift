//
//  AlterViewActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation

enum AlterViewActions {
    case loadCurrentUser
    case loadedAlters(user: UserUIModel, alters: [AlterUIModel])
    case searchAlters(search: String)
    case filteredAlters(alters: [AlterUIModel])
}
