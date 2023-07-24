//
//  NewThreadActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation

enum NewThreadActions {
    case getAlters
    case setAlters([AlterUIModel], [UserUIModel])
    case setThreadName(String)
    case setThreadPhotoId(String)
    case toggleParticipant(alters: AlterUIModel)
    case toggleSystem(system: UserUIModel)
    case saveThread
    case search(searchString: String)
    case setError(message: String)
    case clearError
}
