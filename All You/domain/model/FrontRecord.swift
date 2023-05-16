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
    let userId: String
    let startTime: Date
    let endTime: Date?
    
    init(id: String, alterId: String, userId: String, startTime: Date, endTime: Date?) {
        self.id = id
        self.alterId = alterId
        self.userId = userId
        self.startTime = startTime
        self.endTime = endTime
    }
    
    init(fromMap: [String: AnyCodable]) throws {
        self.id = fromMap["id"]!.value as! String
        self.alterId = fromMap["atlerId"]!.value as! String
        self.userId = fromMap["userId"]!.value as! String
        self.startTime = fromMap["startTime"]!.value as! Date
        self.endTime = fromMap["endTime"]?.value as? Date
    }
}
