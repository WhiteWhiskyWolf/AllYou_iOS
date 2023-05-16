//
//  FrontReducer.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

struct FrontReducer {
    let reducer: Reducer<FrontState, FrontActions> = { state, action in
        switch(action) {
        case .LoadCurrentUser:
            return state
        case .LoadMoreOtherAlters:
            return state
        case .LoadedSystem(
            searchString: let searchString,
            isCurrentUser: let isCurrentUser,
            selectedSystem: let selectedSystem,
            alters: let alters
        ):
            return FrontState.Loaded(
                searchString: searchString,
                isCurrentUser: isCurrentUser,
                selectedAlter: nil,
                selectedSystem: selectedSystem,
                alters: alters
            )
        case .SetAlters(alters: let alters):
            if case .Loaded(
                let searchString,
                let isCurrentUser,
                let selectedAlter,
                let selectedSystem,
                _,
                _
            ) = state {
                return FrontState.Loaded(
                    searchString: searchString,
                    isCurrentUser: isCurrentUser,
                    selectedAlter: selectedAlter,
                    selectedSystem: selectedSystem,
                    alters: alters
                )
            } else {
                return state
            }
        case .LoadFriend(userId: let userId):
            return state
        case .SetAlterAsFront(alterId: let alterId):
            return state
        case .ReplaceAlterAsFront(alterId: let alterId):
            return state
        case .RemoveAlterFromFront(alterId: let alterId):
            return state
        case .SearchAlter(searchString: let searchString):
            if case .Loaded(
                _,
                let isCurrentUser,
                let selectedAlter,
                let selectedSystem,
                let alters
            ) = state {
                return FrontState.Loaded(
                    searchString: searchString,
                    isCurrentUser: isCurrentUser,
                    selectedAlter: selectedAlter,
                    selectedSystem: selectedSystem,
                    alters: alters
                )
            } else {
                return state
            }
        case .SelectAlter(alterId: let alterId):
            if case .Loaded(
                let searchString,
                let isCurrentUser,
                _,
                let selectedSystem,
                let alters
            ) = state {
                return FrontState.Loaded(
                    searchString: searchString,
                    isCurrentUser: isCurrentUser,
                    selectedAlter: alterId,
                    selectedSystem: selectedSystem,
                    alters: alters
                )
            } else {
                return state
            }
        case .CloseAlter:
            if case .Loaded(
                let searchString,
                let isCurrentUser,
                _,
                let selectedSystem,
                let alters
            ) = state {
                return FrontState.Loaded(
                    searchString: searchString,
                    isCurrentUser: isCurrentUser,
                    selectedAlter: nil,
                    selectedSystem: selectedSystem,
                    alters: alters
                )
            } else {
                return state
            }
        }
    }
}
