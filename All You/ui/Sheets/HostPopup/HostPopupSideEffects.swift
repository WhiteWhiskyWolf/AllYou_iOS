//
//  HostPopupSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

class HostPopupSideEffects {
    @Service var getAltersUseCase: GetUserAltersUseCase
    @Service var getCurrentUserUseCase: GetCurrentUserUseCase
    @Service var searchAltersUseCase: SearchAltersUseCase
    func sideEffects() -> [SideEffect<HostPopupState, HostPopupActions>] {
        return [
            onLoadAlters,
            onSearch
        ]
    }
    
    private func onLoadAlters(oldState: HostPopupState, newState: HostPopupState, action: HostPopupActions, dispatch: Dispatch<HostPopupActions>) async {
        if case .loadAlters = action {
            if let currentUser = await getCurrentUserUseCase.invoke() {
                let altersStream = getAltersUseCase.invoke(userId: currentUser.id, lastAlterId: nil)
                for await alters in altersStream {
                    dispatch(HostPopupActions.loadedAlters(alters: alters))
                }
            }
        }
    }
    
    private func onSearch(oldState: HostPopupState, newState: HostPopupState, action: HostPopupActions, dispatch: Dispatch<HostPopupActions>) async {
        if case .searchAlter(searchString: let searchString) = action {
            if let currentUser = await getCurrentUserUseCase.invoke() {
                let alters = await searchAltersUseCase.invoke(userId: currentUser.id, search: searchString)
                dispatch(HostPopupActions.loadedAlters(alters: alters))
            }
        }
    }
}
