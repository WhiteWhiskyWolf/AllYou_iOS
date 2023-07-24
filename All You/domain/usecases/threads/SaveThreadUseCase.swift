//
//  SaveThreadUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-23.
//

import Foundation

class SaveThreadUseCase {
    @Service var threadRepository: ThreadRepository
    
    func invoke(
        threadName: String,
        alterParticipants: [AlterUIModel],
        threadPhotoId: String?
    ) async {
        let participants = alterParticipants.map{ alter in
            alter.id
        }
        var thread = ThreadModel(
            threadId: UUID().uuidString,
            threadPhotoId: threadPhotoId,
            threadName: threadName,
            participantAlterIds: participants,
            lastMessage: nil,
            lastMessageTime: nil
        )
        
        await threadRepository.saveThread(threadModel: thread)
    }
}
