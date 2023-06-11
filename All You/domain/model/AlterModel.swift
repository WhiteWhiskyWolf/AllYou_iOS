//
//  AlterModel.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation

struct AlterModel: Codable {
    let id: String
    let profileId: String
    let alterName: String?
    let alterPronouns: String?
    let alterDescription: String?
    let alterRole: String?
    let alterColor: String
    let alterProfilePhoto: String?
    
    init(id: String, profileId: String, alterName: String?, alterPronouns: String?, alterDescription: String?, alterRole: String?, alterColor: String, alterProfilePhoto: String?) {
        self.id = id
        self.profileId = profileId
        self.alterName = alterName
        self.alterPronouns = alterPronouns
        self.alterDescription = alterDescription
        self.alterRole = alterRole
        self.alterColor = alterColor
        self.alterProfilePhoto = alterProfilePhoto
    }
}
