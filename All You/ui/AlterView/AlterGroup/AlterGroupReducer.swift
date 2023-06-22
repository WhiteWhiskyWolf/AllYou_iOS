//
//  AlterGroupReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

struct AlterGroupReducer {
    let reducer: Reducer<AlterGroupState, AlterGroupActions> = { state, action in
        switch(action) {
        case .toggleExpanded:
            if case .loaded(alter: let alter, subAlters: let subAlters, expanded: let expanded) = state {
                return AlterGroupState.loaded(alter: alter, subAlters: subAlters, expanded: !expanded)
            } else {
                return state
            }
        case .loadAlter(alter: let alter):
            return state
        case .loadedAlter(alter: let alter, subAlters: let subAlters):
            return AlterGroupState.loaded(alter: alter, subAlters: subAlters, expanded: false)
        }
    }
}
