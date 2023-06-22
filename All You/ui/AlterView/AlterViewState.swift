//
//  AlterViewState.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation


enum AlterViewState {
    case loading
    case loaded(
        system: UserUIModel,
        alters: [AlterUIModel],
        search: String?,
        filteredAlters: [AlterUIModel]
    )
}
