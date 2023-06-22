//
//  AlterGroupSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

class AlterGroupSideEffects {
    @Service var getSubAltersUseCase: GetSubAltersUseCase
    
    func sideEffects() -> [SideEffect<AlterGroupState, AlterGroupActions>] {
        return [
            onLoadAlter
        ]
    }
    
    private func onLoadAlter(previousState: AlterGroupState, newState: AlterGroupState, action: AlterGroupActions, dispatch: Dispatch<AlterGroupActions>) async {
        if case .loadAlter(let alter) = action {
            let subAlters = await getSubAltersUseCase.invoke(alterId: alter.id)
            dispatch(AlterGroupActions.loadedAlter(alter: alter, subAlters: subAlters))
        }
    }
}
