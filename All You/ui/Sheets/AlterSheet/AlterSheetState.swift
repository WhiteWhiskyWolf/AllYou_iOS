//
//  AlterSheetState.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

enum AlterSheetState {
    case Loading
    case Loaded(
        alter: AlterUIModel,
        host: AlterUIModel?,
        isCurrentUser: Bool,
        displayHostSelection: Bool
    )
}
