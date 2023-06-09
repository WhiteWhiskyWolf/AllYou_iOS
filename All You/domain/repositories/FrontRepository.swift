//
//  FrontRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation
import Appwrite
import os
import Combine

class FrontRepository {
    @Service var appwriteClient: AppwriteClient
    private lazy var database: Databases = { Databases(appwriteClient.getClient()) }()
    private lazy var realtime: Realtime = { Realtime(appwriteClient.getClient()) }()
    private let logger = Logger(subsystem: "FrontRepository", category: "background")
    
    func listenForUpdates() -> AsyncStream<Bool> {
        return AsyncStream(Bool.self) { cont in
            cont.yield(true)
            _ = realtime.subscribe(
                channel: "databases.\(appwriteClient.getDatabaseId()).collections.\(appwriteClient.getFrontRepisotry()).documents",
                callback: { data in
                    if (data.events?.isEmpty == false) {
                        cont.yield(true)
                    }
                }
            )
        }
    }
    
    func getLastFrontRecordForAlter(alterId: String) async -> FrontRecord? {
        do {
            let documents = try await database.listDocuments(
                databaseId: appwriteClient.getDatabaseId(),
                collectionId: appwriteClient.getFrontRepisotry(),
                queries: [
                    Query.equal("alterId", value: alterId),
                    Query.limit(1),
                    Query.orderDesc("startTime")
                ]
            )
            if (documents.documents.isEmpty) {
                return nil
            }
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxxx"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let jsonData = try documents.documents.first?.data.toJson().data(using: .utf8)
            return try decoder.decode(FrontRecord.self, from: jsonData!)
        } catch {
            logger.error("Unable to get front records: \(String(describing: error))")
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
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try documents.documents.map { record in
                let jsonData = try documents.documents.first?.data.toJson().data(using: .utf8)
                return try decoder.decode(FrontRecord.self, from: jsonData!)
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
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(frontRecord)
            
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
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(frontRecord)
            
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
