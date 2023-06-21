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
        case .LoadAlter(alterId: let alterId):
            return state
        case .LoaedAlter(alter: let alter, isCurrentUser: let isCurrentUser, host: let host):
            return AlterSheetState.Loaded(alter: alter, host: host, isCurrentUser: isCurrentUser, displayHostSelection: false)
        case .UpdateName(name: let name):
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: let displayHostSelection) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterName: name), host: host, isCurrentUser: isCurrentUser, displayHostSelection: displayHostSelection)
            }
            return state
        case .UpdatePronouns(pronouns: let pronouns):
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: let displayHostSelection) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterPronouns: pronouns), host: host, isCurrentUser: isCurrentUser, displayHostSelection: displayHostSelection)
            }
            return state
        
        case .UpdateColor(color: let color):
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: let displayHostSelection) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterColor: color), host: host, isCurrentUser: isCurrentUser, displayHostSelection: displayHostSelection)
            }
            return state
        case .UploadPhoto(alterId: let alterId, alterPhoto: let alterPhoto):
            return state
        case .SaveAlter:
            return AlterSheetState.Loading
        case .UpdatePhotoId(photoId: let photoId):
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: let displayHostSelection) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterProfilePhotoId: photoId), host: host, isCurrentUser: isCurrentUser, displayHostSelection: displayHostSelection)
            }
            return state
        case .UpdateDescription(description: let description):
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: let displayHostSelection) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterDescription: description), host: host, isCurrentUser: isCurrentUser, displayHostSelection: displayHostSelection)
            }
            return state
        case .UpdateRole(role: let role):
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: let displayHostSelection) = state {
                return AlterSheetState.Loaded(alter: alter.copy(alterRole: role), host: host, isCurrentUser: isCurrentUser, displayHostSelection: displayHostSelection)
            }
            return state
        case .SplitAlter:
            return state
        case .SelectHost:
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: _) = state {
                return AlterSheetState.Loaded(alter: alter, host: host, isCurrentUser: isCurrentUser, displayHostSelection: true)
            }
            return state
        case .SelectedHost(alterId: _):
            if case .Loaded(alter: let alter, host: let host, isCurrentUser: let isCurrentUser, displayHostSelection: _) = state {
                return AlterSheetState.Loaded(alter: alter, host: host, isCurrentUser: isCurrentUser, displayHostSelection: false)
            }
            return state
        }
    }
}
