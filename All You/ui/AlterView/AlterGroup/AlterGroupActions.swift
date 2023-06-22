//
//  AlterGroupActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

enum AlterGroupActions {
    case toggleExpanded
    case loadAlter(alter: AlterUIModel)
    case loadedAlter(alter: AlterUIModel, subAlters: [AlterUIModel])
}
