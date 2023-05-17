//
//  GetAlterByIDUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

class GetAlterByIDUseCase {
    @Service var alterRepository: AlterRepository
    @Service var profilePhotoRepository: ProfilePhotoRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(alterId: String) async -> AlterUIModel? {
        return if let alter = await alterRepository.getAltersById(id: alterId) {
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
