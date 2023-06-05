//
//  AlterUIModel.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

struct AlterUIModel: Identifiable {
    let id: String
    let profileId: String
    let alterName: String?
    let alterPronouns: String?
    let alterDescription: String?
    let alterRole: String?
    let alterColor: String
    let alterProfilePhoto: Data?
    let alterProfileId: String?
    let frontingDate: Date?
    let isFronting: Bool
    
    init(id: String, profileId: String, alterName: String?, alterPronouns: String?, alterDescription: String?, alterRole: String?, alterColor: String, alterProfilePhoto: Data?, alterProfileId: String?, isFronting: Bool, frontingDate: Date?) {
        self.id = id
        self.profileId = profileId
        self.alterName = alterName
        self.alterPronouns = alterPronouns
        self.alterDescription = alterDescription
        self.alterRole = alterRole
        self.alterColor = alterColor
        self.alterProfilePhoto = alterProfilePhoto
        self.alterProfileId = alterProfileId
        self.isFronting = isFronting
        self.frontingDate = frontingDate
    }
    
    init(fromAlterModel: AlterModel, profilePhotoData: Data?, isFronting: Bool, frontingDate: Date?) {
        self.id = fromAlterModel.id
        self.profileId = fromAlterModel.profileId
        self.alterName = fromAlterModel.alterName
        self.alterPronouns = fromAlterModel.alterPronouns
        self.alterDescription = fromAlterModel.alterDescription
        self.alterRole = fromAlterModel.alterRole
        self.alterColor = fromAlterModel.alterColor
        self.alterProfilePhoto = profilePhotoData
        self.alterProfileId = fromAlterModel.alterProfilePhoto
        self.isFronting = isFronting
        self.frontingDate = frontingDate
    }
    
    func copy(
        id: String? = nil,
        profileId: String? = nil,
        alterName: String? = nil,
        alterPronouns: String? = nil,
        alterDescription: String? = nil,
        alterRole: String? = nil,
        alterColor: String? = nil,
        alterProfilePhoto: Data? = nil,
        isFronting: Bool? = nil,
        frontingDate: Date? = nil
    ) -> AlterUIModel {
        return AlterUIModel(
            id: id ?? self.id,
            profileId: profileId ?? self.profileId,
            alterName: alterName ?? self.alterName,
            alterPronouns: alterPronouns ?? self.alterPronouns,
            alterDescription: alterDescription ?? self.alterDescription,
            alterRole: alterRole ?? self.alterRole,
            alterColor: alterColor ?? self.alterColor,
            alterProfilePhoto: alterProfilePhoto ?? self.alterProfilePhoto,
            alterProfileId: self.alterProfileId,
            isFronting: isFronting ?? self.isFronting,
            frontingDate: frontingDate ?? self.frontingDate
        )
    }
    
    func toDomainModel(profilePhotoId: String? = nil) -> AlterModel {
        return AlterModel(
            id: self.id,
            profileId: self.profileId,
            alterName: self.alterName,
            alterPronouns: self.alterPronouns,
            alterDescription: self.alterDescription,
            alterRole: self.alterRole,
            alterColor: self.alterColor,
            alterProfilePhoto: profilePhotoId ?? self.alterProfileId
        )
    }
}
