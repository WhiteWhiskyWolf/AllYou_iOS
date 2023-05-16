//
//  GetUserAltersUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-01.
//

import Foundation

class GetUserAltersUseCase {
    @Service var alterRepository: AlterRepository
    @Service var profilePhotoRepository: ProfilePhotoRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(userId: String, lastAlterId: String?) async -> [AlterUIModel] {
        let alters = await alterRepository.getAltersForUser(lastAlterId: lastAlterId, userId: userId)
        return await alters.asyncMap { alter in
            var profilePhoto: Data? = nil
            if (alter.alterProfilePhoto != nil) {
                profilePhoto = await profilePhotoRepository.getPhotoForUser(id: alter.alterProfilePhoto!)
            }
            let frontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
            var isFronting = frontRecord != nil && frontRecord?.endTime != nil
            return AlterUIModel(
                fromAlterModel: alter,
                profilePhotoData: profilePhoto,
                isFronting: isFronting,
                frontingDate: frontRecord?.endTime ?? frontRecord?.startTime
            )
        }
    }
}
