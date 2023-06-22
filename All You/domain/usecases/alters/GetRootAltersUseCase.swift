//
//  GetRootAltersUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation
import AsyncAlgorithms

class GetRootAltersUseCase {
    @Service var alterRepository: AlterRepository
    @Service var frontRepository: FrontRepository
    
    func invoke(userId: String) -> AsyncStream<[AlterUIModel]> {
        return AsyncStream([AlterUIModel].self) { cont in
            Task {
                let alterStream = await alterRepository.listenToAltersForUser(userId: userId)
                let frontRecordStream = frontRepository.listenForUserFrontRecords(userId: userId)
                for await (alters, records) in combineLatest(alterStream, frontRecordStream) {
                    let filteredAlters = alters.filter({ alter in
                        alter.hostId?.isEmpty != false
                    })
                    let foundAlters = await filteredAlters.asyncMap { alter in
                        let frontRecord = records.first(where: { record in
                            record.alterId == alter.id
                        })
                        let isFronting = frontRecord != nil && frontRecord?.endTime == nil
                        return AlterUIModel(
                            fromAlterModel: alter,
                            isFronting: isFronting,
                            frontingDate: frontRecord?.endTime ?? frontRecord?.startTime
                        )
                    }
                    
                    cont.yield(foundAlters)
                }
            }
        }
    }
}
