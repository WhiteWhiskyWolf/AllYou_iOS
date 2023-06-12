//
//  AlterRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import FirebaseFirestore
import os
import AlgoliaSearchClient

class AlterRepository {
    private lazy var database = Firestore.firestore().collection("Alters")
    private lazy var searchIndex = RepositoryUtils.getAgoliaClient().index(withName: "alter-search")
    private let logger = Logger(subsystem: "AlterRepository", category: "background")
    
    func searchUserAlters(userId: String, search: String) async -> [AlterModel] {
        do {
            return try await withCheckedThrowingContinuation({ cont in
                var query = AlgoliaSearchClient.Query(search)
                query.filters = "profileId:\(userId)"
                
                searchIndex.search(query: query) { result in
                    switch(result) {
                    case .success(let response):
                        do {
                            let results: [AlterModel] =  try response.extractHits()
                            cont.resume(returning: results)
                        } catch {
                            self.logger.error("Unable to search: \(error.localizedDescription)")
                            cont.resume(throwing: error)
                        }
                    case .failure(let error):
                        self.logger.error("Unable to search alters: \(error.localizedDescription)")
                        cont.resume(returning: [])
                    }
                }
            })
        } catch {
            logger.error("Unable to search: \(error.localizedDescription)")
            return []
        }
    }
    
    func getAltersById(id: String) async -> AlterModel? {
        if (id.isEmpty) {
            return nil
        }
        
        do {
            let docSnapshot = try await database.document(id).getDocument()
            
            if (!docSnapshot.exists) {
                return nil
            }
            
            return RepositoryUtils.decodeObject(AlterModel.self, data: docSnapshot.data()!)
        } catch {
            logger.error("Unable to get alters by id \(error.localizedDescription)")
            return nil
        }
    }
    
    func listenToAltersForUser(userId: String) async -> AsyncStream<[AlterModel]> {
        return AsyncStream([AlterModel].self) { cont in
            database
                .whereField("profileId", isEqualTo: userId)
                .addSnapshotListener { snapshot, error in
                    if (error != nil) {
                        self.logger.error("Unable to get front records: \(error.debugDescription)")
                        cont.yield([])
                    }
                    
                    let alterRecords = snapshot?.documents.compactMap { record in
                        RepositoryUtils.decodeObject(AlterModel.self, data: record.data())
                    }
                    cont.yield(alterRecords ?? [])
                }
        }
    }
    
    func saveAlter(alterModel: AlterModel, userId: String) async {
        do {
            let foundAtler = database.document(alterModel.id)
            let jsonData = RepositoryUtils.encodeObject(data: alterModel)
            if (jsonData != nil) {
                try await foundAtler.setData(jsonData!, merge: true)
            }
        } catch {
            logger.error("Unabel to save user: \(error.localizedDescription)")
        }
    }
}
