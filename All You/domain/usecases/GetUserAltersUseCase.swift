//
//  GetUserAltersUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

class GetUserAltersUseCase {
    @Service var alterRepository: AlterRepository
    @Service var profilePhotoRepository: ProfilePhotoRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(userId: String, lastAlterId: String?) async -> [AlterUIModel] {
        let alters = await alterRepository.getAltersForUser(lastAlterId: lastAlterId, userId: userId)
        return await alters.asyncMap { alter in
            let frontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
            let isFronting = frontRecord != nil && frontRecord?.endTime != nil
            return AlterUIModel(
                fromAlterModel: alter,
                isFronting: isFronting,
                frontingDate: frontRecord?.endTime ?? frontRecord?.startTime
            )
        }
    }
}
