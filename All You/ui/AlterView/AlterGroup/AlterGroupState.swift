//
//  AlterGroupState.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

enum AlterGroupState {
    case loading
    case loaded(
        alter: AlterUIModel,
        subAlters: [AlterUIModel],
        expanded: Bool
    )
}
