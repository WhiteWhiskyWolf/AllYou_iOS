//
//  AlterReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

struct AlterSheetReducer {
    let reducer: Reducer<AlterSheetState, AlterSheetActions> = { state, action in
        switch (action) {
        case .LoadAlter(let alterId):
            return state
        case .LoaedAlter(let alter, let isCurrentUser):
            return AlterSheetState.Loaded(alter: alter, isCurrentUser: isCurrentUser)
        case .UpdateName(name: let name):
            if case .Loaded(alter: let alter, isCurrentUser: let isCurrentUser) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterName: name), isCurrentUser: isCurrentUser)
            }
            return state
        case .UpdatePronouns(pronouns: let pronouns):
            if case .Loaded(alter: let alter, isCurrentUser: let isCurrentUser) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterPronouns: pronouns), isCurrentUser: isCurrentUser)
            }
            return state
        
        case .UpdateColor(color: let color):
            if case .Loaded(alter: let alter, isCurrentUser: let isCurrentUser) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterColor: color), isCurrentUser: isCurrentUser)
            }
            return state
        case .UploadPhoto(alterId: let alterId, alterPhoto: let alterPhoto):
            return state
        case .SaveAlter:
            return AlterSheetState.Loading
        case .UpdatePhotoId(photoId: let photoId):
            if case .Loaded(alter: let alter, isCurrentUser: let isCurrentUser) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterProfilePhotoId: photoId), isCurrentUser: isCurrentUser)
            }
            return state
        }
    }
}
