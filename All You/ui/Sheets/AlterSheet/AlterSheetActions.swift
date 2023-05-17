//
//  AlterSheetActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

enum AlterSheetActions {
    case LoadAlter(alterId: String)
    case LoaedAlter(alter: AlterUIModel, isCurrentUser: Bool)
}
