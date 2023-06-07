//
//  GetAlterByIDUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

class GetAlterByIDUseCase {
    @Service var alterRepository: AlterRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(alterId: String) async -> AlterUIModel? {
        if let alter = await alterRepository.getAltersById(id: alterId) {
            let frontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
            let isFronting = frontRecord != nil && frontRecord?.endTime != nil
            return AlterUIModel(
                fromAlterModel: alter,
                isFronting: isFronting,
                frontingDate: frontRecord?.endTime ?? frontRecord?.startTime
            )
        }
        return nil
    }
}
