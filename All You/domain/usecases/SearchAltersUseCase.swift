//
//  SearchAltersUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

class SearchAltersUseCase {
    @Service var alterRepository: AlterRepository
    @Service var profilePhotoRepository: ProfilePhotoRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(userId: String, search: String) async -> [AlterUIModel] {
        return await alterRepository.searchUserAlters(userId: userId, search: search).asyncMap { alter in
            var profilePhoto: Data? = nil
            if (alter.alterProfilePhoto != nil) {
                profilePhoto = await profilePhotoRepository.getPhotoForUser(id: alter.alterProfilePhoto!)
            }
            let frontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
            let isFronting = frontRecord != nil && frontRecord?.endTime != nil
            return AlterUIModel(
                fromAlterModel: alter,
                profilePhotoData: profilePhoto,
                isFronting: isFronting,
                frontingDate: frontRecord?.endTime ?? frontRecord?.startTime
            )
        }
    }
}
