//
//  UserModel.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation

struct UserModel: Codable {
    let userId: String
    let systemName: String
    let systemPronoun: String
    let systemColor: String
    let systemProfileId: String?
    
    init(userId: String, systemName: String, systemPronoun: String, systemColor: String, systemProfileId: String?) {
        self.userId = userId
        self.systemName = systemName
        self.systemPronoun = systemPronoun
        self.systemColor = systemColor
        self.systemProfileId = systemProfileId
    }
}
