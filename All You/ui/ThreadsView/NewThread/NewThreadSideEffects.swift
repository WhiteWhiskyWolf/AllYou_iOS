//
//  NewThreadSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-23.
//

import Foundation

class NewThreadsSideEffects {
    @Service var searchAltersUseCase: SearchAltersUseCase
    @Service var getAllVisibleAltersUseCase: GetAllVisibleAltersUseCase
    @Service var saveThreadUseCase: SaveThreadUseCase
    @Service var uploadProfilePhotoUseCase: UploadProfilePhotoUseCase
    @Service var getVisibleSystemsUseCase: GetVisibleSystemsUseCase
    
    func sideEffects() -> [SideEffect<NewThreadState, NewThreadActions>] {
        return [
            onLoad,
            onSaveThread
        ]
    }
    
    private func onLoad(previousState: NewThreadState, newState: NewThreadState, action: NewThreadActions, dispatch: Dispatch<NewThreadActions>) async {
        if case .getAlters = action {
            let alters = await getAllVisibleAltersUseCase.invoke()
            let visibleSystems = await getVisibleSystemsUseCase.invoke()
            dispatch(NewThreadActions.setAlters(alters, visibleSystems))
        }
    }
    
    private func onSaveThread(previousState: NewThreadState, newState: NewThreadState, action: NewThreadActions, dispatch: Dispatch<NewThreadActions>) async {
        if case .saveThread = action {
            await saveThreadUseCase.invoke(threadName: newState.threadName, alterParticipants: newState.alterParticipants, threadPhotoId: newState.threadPhotoId)
        }
    }
    
    private func onSearch(previousState: NewThreadState, newState: NewThreadState, action: NewThreadActions, dispatch: Dispatch<NewThreadActions>) async {
        if case .search(let searchString) = action {
            if searchString.isEmpty {
                let alters = await getAllVisibleAltersUseCase.invoke()
                let visibleSystems = await getVisibleSystemsUseCase.invoke()
                dispatch(NewThreadActions.setAlters(alters, visibleSystems))
            } else {
                let alters = await getAllVisibleAltersUseCase.invoke().filter({ alter in
                    (alter.alterName ?? "").contains(searchString)
                })
                let visibleSystems = await getVisibleSystemsUseCase.invoke()
                dispatch(NewThreadActions.setAlters(alters, visibleSystems))
            }
        }
    }
}
