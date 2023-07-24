//
//  ThreadsViewSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-07-19.
//

import Foundation

class ThreadsViewSideEffects {
    func sideEffects() -> [SideEffect<ThreadsViewState, ThreadsViewActions>] {
        return [
            onLoadThreads,
        ]
    }
    
    private func onLoadThreads(previousState: ThreadsViewState, newState: ThreadsViewState, action: ThreadsViewActions, dispatch: Dispatch<ThreadsViewActions>) async {
        if case .LoadThreads = action {
            dispatch(.LoadedThreads(threads: []))
        }
    }
}
