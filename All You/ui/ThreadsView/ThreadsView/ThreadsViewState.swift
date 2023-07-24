//
//  ThreadsViewState.swift
//  All You
//
//  Created by Cate Daniel on 2023-07-19.
//

import Foundation

enum ThreadsViewState {
    case Loading
    case Loaded(
        displayNewThreads: Bool,
        threads: [ThreadUIModel]
    )
}
