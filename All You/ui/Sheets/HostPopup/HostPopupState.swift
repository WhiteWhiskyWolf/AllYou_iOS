//
//  HostPopupState.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

struct HostPopupState {
    let searchString: String
    let alters: [AlterUIModel]
    
    func copy(searchString: String? = nil, alters: [AlterUIModel]? = nil) -> HostPopupState{
        return HostPopupState(searchString: searchString ?? self.searchString, alters: alters ?? self.alters)
    }
}
