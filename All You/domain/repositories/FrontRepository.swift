//
//  FrontRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-01.
//

import Foundation
import Appwrite
import os

class FrontRepository {
    @Service var appwriteClient: AppwriteClient
    private lazy var database: Databases = { Databases(appwriteClient.getClient()) }()
    private let logger = Logger(subsystem: "FrontRepository", category: "background")
    
    private let collectionId = ""
    
    func getLastFrontRecordForAlter(alterId: String) async -> FrontRecord? {
        do {
            let documents = try await database.listDocuments(
                databaseId: appwriteClient.getDatabaseId(),
                collectionId: appwriteClient.getFrontRepisotry(),
                queries: [
                    Query.equal("profileId", value: alterId),
                    Query.limit(1),
                    Query.orderDesc("startTime")
                ]
            )
            if (documents.documents.isEmpty) {
                return nil
            }
            return try FrontRecord(fromMap: documents.documents.first!.data)
        } catch {
            logger.error("Unable to get front records: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getCurrentFrontRecordsForUser(userId: String) async -> [FrontRecord] {
        do {
            let documents = try await database.listDocuments(
                databaseId: appwriteClient.getDatabaseId(),
                collectionId: appwriteClient.getFrontRepisotry(),
                queries: [
                    Query.equal("userId", value: userId),
                    Query.isNull("endTime")
                ]
            )
            return try documents.documents.map { record in
                try FrontRecord(fromMap: record.data)
            }
        } catch {
            logger.error("Unable to find front recrods \(error.localizedDescription)")
            return []
        }
    }
    
    func saveFrontRecord(frontRecord: FrontRecord) async -> Bool {
        do {
            _ = try await database.getDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getFrontRepisotry(), documentId: frontRecord.id)
            return await updateRecord(frontRecord: frontRecord)
        } catch {
            // new user
            return await createRecord(frontRecord: frontRecord)
        }
    }
    
    private func updateRecord(frontRecord: FrontRecord) async -> Bool {
        do {
            let data = try JSONEncoder().encode(frontRecord)
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            _ = try await database.updateDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getFrontRepisotry(), documentId: frontRecord.id, data: jsonDict)
            return true
        } catch {
            logger.error("Unable to update front record: \(error.localizedDescription)")
            return false
        }
    }
    
    private func createRecord(frontRecord: FrontRecord) async -> Bool {
        do {
            let data = try JSONEncoder().encode(frontRecord)
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                _ = try await database.createDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getFrontRepisotry(), documentId: frontRecord.id, data: jsonDict)
            }
            return true
        } catch {
            logger.error("Unable to create front recrord: \(error)")
            return false
        }
    }
}
