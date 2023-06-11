//
//  FrontRecord.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

struct FrontRecord: Codable {
    let id: String
    let alterId: String
    let profileId: String
    let startTime: Date
    let endTime: Date?
    
    func copy(
        id: String? = nil,
        alterId: String? = nil,
        profileId: String? = nil,
        startTime: Date? = nil,
        endTime: Date? = nil
    ) -> FrontRecord {
        return FrontRecord(
            id: id ?? self.id,
            alterId: alterId ?? self.alterId,
            profileId: profileId ?? self.profileId,
            startTime: startTime ?? self.startTime,
            endTime: endTime ?? self.endTime
        )
    }
}
