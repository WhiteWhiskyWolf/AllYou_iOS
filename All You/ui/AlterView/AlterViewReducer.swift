//
//  AlterViewReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation

struct AlterViewReducer {
    let reducer: Reducer<AlterViewState, AlterViewActions> = {state, action in
        switch(action) {
        case .loadCurrentUser:
            return AlterViewState.loading
        case .loadedAlters(user: let user, alters: let alters):
            return AlterViewState.loaded(system: user, alters: alters, search: "", filteredAlters: [])
        case .searchAlters(search: let search):
            if case .loaded(system: let system, alters: let alters, search: _, filteredAlters: let filteredAlters) = state {
                return AlterViewState.loaded(system: system, alters: alters, search: search, filteredAlters: filteredAlters)
            } else {
                return state
            }
        case .filteredAlters(alters: let filteredAlters):
            if case .loaded(system: let system, alters: let alters, search: let search, filteredAlters: _) = state {
                return AlterViewState.loaded(system: system, alters: alters, search: search, filteredAlters: filteredAlters)
            } else {
                return state
            }
        }
    }

}
