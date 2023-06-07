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
    @Service var setAlterToFrontUseCase: SetAlterToFrontUseCase
    @Service var removeAlterFromFrontUseCase: RemoveAlterFromFrontUseCase
    
    func sideEffects() -> [SideEffect<FrontState, FrontActions>] {
        return [
            onLoadSideEffect,
            onSearchSideEffect,
            onMoveAlterToFront,
            onRemoveAlterToFront
        ]
    }
    
    private func onMoveAlterToFront(previousState: FrontState, newState: FrontState, action: FrontActions, dispatch: Dispatch<FrontActions>) async {
        if case .SetAlterAsFront(let alter) = action {
            await setAlterToFrontUseCase.invoke(alter: alter)
        }
    }
    
    private func onRemoveAlterToFront(previousState: FrontState, newState: FrontState, action: FrontActions, dispatch: Dispatch<FrontActions>) async {
        if case .RemoveAlterFromFront(alter: let alter) = action {
            await removeAlterFromFrontUseCase.invoke(alter: alter)
        }
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
