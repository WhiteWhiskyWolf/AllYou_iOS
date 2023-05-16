//
//  FrontSideEffects.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-01.
//

import Foundation

class FrontSideEffects {
    @Service var getCurrentUserUseCase: GetCurrentUserUseCase
    @Service var getUserAltersUseCase: GetUserAltersUseCase
    
    func sideEffects() -> [SideEffect<FrontState, FrontActions>] {
        return [
            onLoadSideEffect
        ]
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
