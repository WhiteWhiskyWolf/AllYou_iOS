//
//  GetSubAltersUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import Foundation

class GetSubAltersUseCase {
    @Service var alterRepository: AlterRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(alterId: String) async -> [AlterUIModel] {
        return await alterRepository.getSubAltersForAlter(alterId: alterId).asyncMap { alter in
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
