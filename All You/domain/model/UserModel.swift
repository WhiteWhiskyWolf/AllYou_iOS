//
//  UserModel.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import JSONCodable

struct UserModel: Codable {
    let userId: String
    let systemName: String
    let systemPronoun: String
    let systemColor: String
    let systemProfileId: String?
    
    init(userId: String, systemName: String, systemPronoun: String, systemColor: String, systemProfileId: String?) {
        self.userId = userId
        self.systemName = systemName
        self.systemPronoun = systemPronoun
        self.systemColor = systemColor
        self.systemProfileId = systemProfileId
    }
    
    init(fromDict: [String: AnyCodable]) {
        self.userId = fromDict["userId"]?.value as! String
        self.systemName = fromDict["systemName"]?.value as! String
        self.systemPronoun = fromDict["systemPronoun"]?.value as! String
        self.systemColor = fromDict["systemColor"]?.value as! String
        self.systemProfileId = fromDict["systemProfileId"]?.value as? String
    }
}
