//
//  UserRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import os
import Firebase

class UserRepsoitory {
    private lazy var database = Firestore.firestore().collection("Users")
    private let logger = Logger(subsystem: "UserRepository", category: "background")
    
    func getUser(userId: String) async -> UserModel? {
        do {
            let user = try await database.document(userId).getDocument()
            if (user.data() == nil) {
                return nil
            }
            return RepositoryUtils.decodeObject(UserModel.self, data: user.data()!)
        } catch {
            logger.error("Unabel to get user: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    func saveUser(userModel: UserModel) async {
        do {
            let foundUser = database.document(userModel.userId)
            let jsonUser = RepositoryUtils.encodeObject(data: userModel)
            if (jsonUser != nil) {
                try await foundUser.setData(jsonUser!, merge: true)
            }
        } catch {
            logger.error("Unabel to save user: \(error.localizedDescription)")
        }
    }
}
