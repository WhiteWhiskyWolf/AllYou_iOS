//
//  GetUserAltersUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation
import AsyncAlgorithms

class GetUserAltersUseCase {
    @Service var alterRepository: AlterRepository
    @Service var profilePhotoRepository: ProfilePhotoRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(userId: String, lastAlterId: String?) -> AsyncStream<[AlterUIModel]> {
        return AsyncStream([AlterUIModel].self) { cont in
            Task {
                let alterStream = await alterRepository.listenToAltersForUser(userId: userId)
                let frontRecordStream = frontRepository.listenForUpdates()
                for await (alters, _) in combineLatest(alterStream, frontRecordStream) {
                    let alters = await alters.asyncMap { alter in
                        let frontRecord = await frontRepository.getLastFrontRecordForAlter(alterId: alter.id)
                        let isFronting = frontRecord != nil && frontRecord?.endTime == nil
                        return AlterUIModel(
                            fromAlterModel: alter,
                            isFronting: isFronting,
                            frontingDate: frontRecord?.endTime ?? frontRecord?.startTime
                        )
                    }
                    cont.yield(alters)
                }
            }
        }
    }
}
