//
//  AlterViewSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation


class AlterViewSideEffects {
    @Service var getCurrentUserUseCase: GetCurrentUserUseCase
    @Service var searchAltersUseCase: SearchAltersUseCase
    @Service var getRootAltersUseCase: GetRootAltersUseCase
    
    func sideEffects() -> [SideEffect<AlterViewState, AlterViewActions>] {
        return [
            onLoadUser,
            searchAlters
        ]
    }
    
    private func onLoadUser(previousState: AlterViewState, newState: AlterViewState, action: AlterViewActions, dispatch: Dispatch<AlterViewActions>) async {
        if case .loadCurrentUser = action {
            if let currentUser = await getCurrentUserUseCase.invoke() {
                let rootAltersStream = getRootAltersUseCase.invoke(userId: currentUser.id)
                for await alters in rootAltersStream {
                    dispatch(AlterViewActions.loadedAlters(user: currentUser, alters: alters))
                }
            }
        }
    }
    
    private func searchAlters(previousState: AlterViewState, newState: AlterViewState, action: AlterViewActions, dispatch: Dispatch<AlterViewActions>) async {
        if case .searchAlters(let search) = action {
            if case .loaded(let system, _, _, _) = newState {
                let foundAlters = await searchAltersUseCase.invoke(userId: system.id, search: search)
                dispatch(AlterViewActions.filteredAlters(alters: foundAlters))
            }
        }
    }
}
