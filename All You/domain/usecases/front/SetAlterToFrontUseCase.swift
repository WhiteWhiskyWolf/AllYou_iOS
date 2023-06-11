//
//  SetAlterToFrontUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

class SetAlterToFrontUseCase {
    @Service var frontRepository: FrontRepository
    
    func invoke(alter: AlterUIModel) async {
        let exisitngFrontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
        if (exisitngFrontRecord != nil && exisitngFrontRecord?.endTime == nil) {
            return // Alter is already up front
        }
        
        let frontRecord = FrontRecord(
            id: UUID().uuidString,
            alterId: alter.id,
            profileId: alter.profileId,
            startTime: Date.now,
            endTime: nil
        )
        _ = await frontRepository.saveFrontRecord(frontRecord: frontRecord)
    }
}
