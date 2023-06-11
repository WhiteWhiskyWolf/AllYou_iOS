//
//  UserRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import Appwrite
import os
import Firebase

class UserRepsoitory {
    @Service var appwriteClient: AppwriteClient
    private lazy var database: Databases = { Databases(appwriteClient.getClient()) }()
    private let logger = Logger(subsystem: "UserRepository", category: "background")
    
    func getUser(userId: String) async -> UserModel? {
        do {
            let query = Query.equal("userId", value: userId)
            let documents = try await database.listDocuments(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getUserRepisotry(), queries: [query])
            if (documents.documents.count == 0) {
                return nil
            }
            return UserModel(fromDict: documents.documents.first!.data)
        } catch {
            return nil
        }
    }
    
    
    func saveUser(userModel: UserModel) async {
        do {
            _ = try await database.getDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getUserRepisotry(), documentId: userModel.userId)
            await updateUser(userModel: userModel)
        } catch {
            // new user
            await createUser(userModel: userModel)
        }
    }
    
    private func updateUser(userModel: UserModel) async {
        do {
            let data = try JSONEncoder().encode(userModel)
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            _ = try await database.updateDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getUserRepisotry(), documentId: userModel.userId, data: jsonDict)
        } catch {
            logger.error("Unable to update user: \(error.localizedDescription)")
        }
    }
    
    private func createUser(userModel: UserModel) async {
        do {
            let data = try JSONEncoder().encode(userModel)
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                _ = try await database.createDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getUserRepisotry(), documentId: userModel.userId, data: jsonDict)
            }
        } catch {
            logger.error("Unable to create user: \(error.localizedDescription)")
        }
    }
}
