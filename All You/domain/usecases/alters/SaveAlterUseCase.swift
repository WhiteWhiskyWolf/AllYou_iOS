//
//  SaveAlterUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-05.
//

import Foundation

class SaveAlterUseCase {
    @Service var authenticaitonRepository: AuthenticationRepository
    @Service var alterRepository: AlterRepository
    
    func invoke(alter: AlterUIModel) async {
        let domainModel = alter.toDomainModel()
        if let userId = await authenticaitonRepository.getUserId() {
            await alterRepository.saveAlter(alterModel: domainModel, userId: userId)
        }
    }
}
