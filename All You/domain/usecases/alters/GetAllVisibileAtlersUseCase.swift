//
//  GetAllVisibileAtlersUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-23.
//

import Foundation

class GetAllVisibleAltersUseCase {
    @Service var authenticationRepository: AuthenticationRepository
    @Service var alterRepository: AlterRepository
    @Service var frontRepository: FrontRepository
    
    func invoke() async -> [AlterUIModel] {
        // TODO add friends alters
        if let user = await authenticationRepository.getUserId() {
            let alters = await alterRepository.getAltersForUser(userId: user)
            let alterUiModels = await alters.asyncMap { alter in
                let frontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
                let isFronting = frontRecord != nil && frontRecord?.endTime != nil
                return AlterUIModel(
                    fromAlterModel: alter,
                    isFronting: isFronting,
                    frontingDate: frontRecord?.endTime ?? frontRecord?.startTime
                )
            }
            return alterUiModels
        } else {
            return []
        }
    }
}
