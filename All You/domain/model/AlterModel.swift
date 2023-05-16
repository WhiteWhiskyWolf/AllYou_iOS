//
//  AlterModel.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import JSONCodable

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
    
    init(fromMap: [String: AnyCodable]) {
        self.id = fromMap["$id"]?.value as! String
        self.profileId = fromMap["profileId"]?.value as! String
        self.alterName = fromMap["alterName"]?.value as? String
        self.alterPronouns = fromMap["alterPronouns"]?.value as? String
        self.alterDescription = fromMap["alterDescription"]?.value as? String
        self.alterRole = fromMap["alterRole"]?.value as? String
        self.alterColor = fromMap["alterColor"]?.value as! String
        self.alterProfilePhoto = fromMap["alterProfilePhoto"]?.value as? String
    }
}
