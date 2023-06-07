//
//  RemoveAlterFromFront.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

class RemoveAlterFromFrontUseCase {
    @Service var frontRepository: FrontRepository
    
    func invoke(alter: AlterUIModel) async {
        let exisitngFrontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
        if (exisitngFrontRecord == nil) {
            return // Alter is already not fronting
        }
        
        let saveRecord = exisitngFrontRecord!.copy(endTime: Date.now)
        _ = await frontRepository.saveFrontRecord(frontRecord: saveRecord)
    }
}
