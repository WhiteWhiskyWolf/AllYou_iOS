//
//  ThreadUIModel.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation

struct ThreadUIModel: Identifiable  {
    let id: String
    let threadPhotoId: String?
    let threadName: String
    let participantAlters: [AlterUIModel]
    let lastMessage: String
}
