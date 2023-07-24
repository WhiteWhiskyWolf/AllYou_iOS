//
//  ThreadsViewActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-07-19.
//

import Foundation

enum ThreadsViewActions {
    case LoadThreads
    case LoadedThreads(threads: [ThreadUIModel])
    case DisplayNewThread
    case HideNewThread
}
