//
//  NewThreadState.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation

struct NewThreadState {
    let searchString: String
    let threadName: String
    let alters: [AlterUIModel]
    let systems: [UserUIModel]
    let systemParticipants: [UserUIModel]
    let alterParticipants: [AlterUIModel]
    let threadPhotoId: String?
    let error: String?
    
    func copy(
        searchString: String? = nil,
        threadName: String? = nil,
        systems: [UserUIModel]? = nil,
        alters: [AlterUIModel]? = nil,
        systemParticipants: [UserUIModel]? = nil,
        alterParticipants: [AlterUIModel]? = nil,
        threadPhotoId: String? = nil,
        error: String? = nil
    ) -> NewThreadState {
        return NewThreadState(
            searchString: searchString ?? self.searchString,
            threadName: threadName ?? self.threadName,
            alters: alters ?? self.alters,
            systems: systems ?? self.systems,
            systemParticipants: systemParticipants ?? self.systemParticipants,
            alterParticipants: alterParticipants ?? self.alterParticipants,
            threadPhotoId: threadPhotoId ?? self.threadPhotoId,
            error: error ?? self.error
        )
    }
}
