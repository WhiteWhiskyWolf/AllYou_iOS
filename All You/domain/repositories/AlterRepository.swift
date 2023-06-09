//
//  AlterRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import Appwrite
import os
import Combine

class AlterRepository {
    @Service var appwriteClient: AppwriteClient
    private lazy var database: Databases = { Databases(appwriteClient.getClient()) }()
    private lazy var realtime: Realtime = { Realtime(appwriteClient.getClient()) }()
    private let logger = Logger(subsystem: "UserRepository", category: "background")
    
    func searchUserAlters(userId: String, search: String) async -> [AlterModel] {
        do {
            let documents = try await database.listDocuments(
                databaseId: appwriteClient.getDatabaseId(),
                collectionId: appwriteClient.getAlterRepisotry(),
                queries: [
                    Query.equal("profileId", value: userId),
                    Query.search("text_search", value: search)
                ]
            )
            
            if (documents.documents.isEmpty) {
                return []
            }
            
            return documents.documents.map { alter in
                return AlterModel(fromMap: alter.data)
            }
        } catch {
            logger.error("Unable to search alters: \(error.localizedDescription)")
            return []
        }
    }
    
    func getAltersById(id: String) async ->AlterModel? {
        do {
            let documents = try await database.listDocuments(
                databaseId: appwriteClient.getDatabaseId(),
                collectionId: appwriteClient.getAlterRepisotry(),
                queries: [
                    Query.equal("id", value: id)
                ]
            )
            if (documents.documents.isEmpty) {
                return nil
            } else {
                return AlterModel(fromMap: documents.documents.first!.data)
            }
        } catch {
            logger.error("Unable to get alters by id \(error.localizedDescription)")
            return nil
        }
    }
    
    func listenToAltersForUser(userId: String) async -> AsyncStream<[AlterModel]> {
        return AsyncStream([AlterModel].self) { cont in
            Task {
                let initialAlters = await self.getAltersForUser(lastAlterId: nil, userId: userId)
                cont.yield(initialAlters)
            }
            _ = realtime.subscribe(
                channel: "databases.\(appwriteClient.getDatabaseId()).collections.\(appwriteClient.getAlterRepisotry()).documents",
                callback: { data in
                    if (data.events?.isEmpty == false) {
                        Task.detached {
                            let alterUpdates = await self.getAltersForUser(lastAlterId: nil, userId: userId)
                            cont.yield(alterUpdates)
                        }
                    }
                }
            )
        }
    }
    
    func getAltersForUser(lastAlterId: String?, userId: String) async -> [AlterModel] {
        do {
            var querys = [Query.equal("profileId", value: userId)]
            if (lastAlterId != nil) {
                querys.append(Query.cursorAfter(lastAlterId!))
            }
            let documents = try await database.listDocuments(
                databaseId: appwriteClient.getDatabaseId(),
                collectionId: appwriteClient.getAlterRepisotry(),
                queries: querys
            )
            return documents.documents.map{ record in
                AlterModel.init(fromMap: record.data)
            }
        } catch {
            logger.error("Unable to get alters \(error.localizedDescription)")
            return []
        }
    }
    
    func saveAlter(alterModel: AlterModel) async {
        do {
            _ = try await database.getDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getAlterRepisotry(), documentId: alterModel.id)
            await updateAlter(alterModel: alterModel)
        } catch {
            // new user
            await createAlter(alterModel: alterModel)
        }
    }
    
    private func updateAlter(alterModel: AlterModel) async {
        do {
            let data = try JSONEncoder().encode(alterModel)
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            _ = try await database.updateDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getAlterRepisotry(), documentId: alterModel.id, data: jsonDict)
        } catch {
            logger.error("Unable to update alter: \(error.localizedDescription)")
        }
    }
    
    private func createAlter(alterModel: AlterModel) async {
        do {
            let data = try JSONEncoder().encode(alterModel)
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                _ = try await database.createDocument(databaseId: appwriteClient.getDatabaseId(), collectionId: appwriteClient.getAlterRepisotry(), documentId: alterModel.id, data: jsonDict)
            }
        } catch {
            logger.error("Unale to create alter: \(error.localizedDescription)")
        }
    }
}
