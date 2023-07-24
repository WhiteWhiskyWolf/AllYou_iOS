//
//  SaveThreadUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-23.
//

import Foundation

class SaveThreadUseCase {
    @Service var threadRepository: ThreadRepository
    @Service var alterReposiotry: AlterRepository
    
    func invoke(
        threadName: String,
        alterParticipants: [AlterUIModel],
        systemPartipants: [UserUIModel],
        threadPhotoId: String?
    ) async {
        var selectedParticiapnts: [String] = []
        for systemPartipant in systemPartipants {
            let alters = await alterReposiotry.getAltersForUser(userId: systemPartipant.id)
            selectedParticiapnts.append(contentsOf: alters.map{$0.id})
        }
        
        alterParticipants.forEach { alter in
            selectedParticiapnts.append(alter.id)
        }
        
        var thread = ThreadModel(
            threadId: UUID().uuidString,
            threadPhotoId: threadPhotoId,
            threadName: threadName,
            participantAlterIds: selectedParticiapnts,
            lastMessage: nil,
            lastMessageTime: nil
        )
        
        await threadRepository.saveThread(threadModel: thread)
    }
}
