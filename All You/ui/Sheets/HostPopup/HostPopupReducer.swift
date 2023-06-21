//
//  HostPopupReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

struct HostPopupReducer {
    let reducer: Reducer<HostPopupState, HostPopupActions> = { state, action in
        switch(action) {
        case .searchAlter(searchString: let searchString):
            return state.copy(searchString: searchString)
        case .loadAlters:
            return state
        case .loadedAlters(alters: let alters):
            return state.copy(alters: alters)
        }
    }
}
