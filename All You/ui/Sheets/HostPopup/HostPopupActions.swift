//
//  HostPopupActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

enum HostPopupActions {
    case searchAlter(searchString: String)
    case loadAlters
    case loadedAlters(alters: [AlterUIModel])
}
