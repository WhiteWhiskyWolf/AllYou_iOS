//
//  ThreadsViewReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-07-19.
//

import Foundation

struct ThreadsViewReducer {
    let reducer: Reducer<ThreadsViewState, ThreadsViewActions> = {state, action in
        switch(action) {
        case .LoadThreads:
            return state
        case .LoadedThreads(threads: let threads):
            return ThreadsViewState.Loaded(displayNewThreads: false, threads: threads)
        case .DisplayNewThread:
            if case .Loaded(_, threads: let threads) = state {
                return ThreadsViewState.Loaded(displayNewThreads: true, threads: threads)
            } else {
                return state
            }
        case .HideNewThread:
            if case .Loaded(_, threads: let threads) = state {
                return ThreadsViewState.Loaded(displayNewThreads: false, threads: threads)
            } else {
                return state
            }
        }
    }
}
