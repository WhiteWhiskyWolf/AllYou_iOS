//
//  FrontRecord.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation
import JSONCodable

struct FrontRecord: Codable {
    let id: String
    let alterId: String
    let profileId: String
    let startTime: Date
    let endTime: Date?
    
    init(id: String, alterId: String, profileId: String, startTime: Date, endTime: Date?) {
        self.id = id
        self.alterId = alterId
        self.profileId = profileId
        self.startTime = startTime
        self.endTime = endTime
    }
    
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
