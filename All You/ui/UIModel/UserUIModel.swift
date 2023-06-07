//
//  UserUIModel.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

struct UserUIModel: Identifiable {
    let id: String
    let systemName: String
    let systemPronoun: String
    let systemColor: String
    let systemProfileImage: String?
    
    init(userId: String, systemName: String, systemPronoun: String, systemColor: String, systemProfileImage: String?) {
        self.id = userId
        self.systemName = systemName
        self.systemPronoun = systemPronoun
        self.systemColor = systemColor
        self.systemProfileImage = systemProfileImage
    }
    
    init(userModel: UserModel) {
        self.id = userModel.userId
        self.systemName = userModel.systemName
        self.systemPronoun = userModel.systemPronoun
        self.systemColor = userModel.systemColor
        self.systemProfileImage = userModel.systemProfileId
    }
    
    func toDomainModel() -> UserModel {
        return UserModel(
            userId: self.id,
            systemName: self.systemName,
            systemPronoun: self.systemPronoun,
            systemColor: self.systemColor,
            systemProfileId: self.systemProfileImage
        )
    }
}
