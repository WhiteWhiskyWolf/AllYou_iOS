//
//  ThreadModel.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation

struct ThreadModel: Codable {
    let threadId: String
    let threadPhotoId: String?
    let threadName: String
    let participantAlterIds: [String]
    let lastMessage: String?
    let lastMessageTime: Date?
}
