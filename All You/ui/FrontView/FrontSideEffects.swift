//
//  FrontSideEffects.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

class FrontSideEffects {
    @Service var getCurrentUserUseCase: GetCurrentUserUseCase
    @Service var getUserAltersUseCase: GetUserAltersUseCase
    @Service var searchAltersUseCase: SearchAltersUseCase
    
    func sideEffects() -> [SideEffect<FrontState, FrontActions>] {
        return [
            onLoadSideEffect,
            onSearchSideEffect
        ]
    }
    
    private func onSearchSideEffect(previousState: FrontState, newState: FrontState, action: FrontActions, dispatch: Dispatch<FrontActions>) async {
        if case .SearchAlter(let searchString) = action {
            if case .Loaded(_, _, _, let selectedUser, _) = newState {
                let foundAlters = await searchAltersUseCase.invoke(userId: selectedUser.id, search: searchString)
                dispatch(FrontActions.SetAlters(alters: foundAlters))
            }
        }
    }
    
    private func onLoadSideEffect(previousState: FrontState, newState: FrontState, action: FrontActions, dispatch: Dispatch<FrontActions>) async {
        if case .LoadCurrentUser = action {
            if let currentUser = await getCurrentUserUseCase.invoke() {
                let alters = await getUserAltersUseCase.invoke(userId: currentUser.id, lastAlterId: nil)
                dispatch(
                    FrontActions.LoadedSystem(
                        searchString: "",
                        isCurrentUser: true,
                        selectedSystem: currentUser,
                        alters: alters
                    )
                )
            }
        }
    }
}
