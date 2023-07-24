//
//  NewThreadReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation

struct NewThreadReducer {
    let reducer: Reducer<NewThreadState, NewThreadActions> = {state, action in
        switch(action) {
        case .getAlters:
            return state
        case .setAlters(let alters, let systems):
            return state.copy(systems: systems, alters: alters)
        case .setThreadName(let newName):
            return state.copy(threadName: newName)
        case .setThreadPhotoId(let photoId):
            return state.copy(threadPhotoId: photoId)
        case .toggleParticipant(alters: let alter):
            if (state.alterParticipants.contains(where: {$0.id == alter.id})) {
                return state.copy(alterParticipants: state.alterParticipants.filter({$0.id != alter.id}))
            } else {
                return state.copy(alterParticipants: state.alterParticipants + [alter])
            }
        case .toggleSystem(system: let system):
            if (state.systemParticipants.contains(where: {$0.id == system.id})) {
                return state.copy(systemParticipants: state.systemParticipants.filter({$0.id != system.id}))
            } else {
                return state.copy(systemParticipants: state.systemParticipants + [system])
            }
        case .setError(let error):
            return state.copy(error: error)
        case .saveThread:
            return state
        case .search(searchString: let searchString):
            return state.copy(searchString: searchString)
        }
    }
}
