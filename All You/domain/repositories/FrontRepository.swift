//
//  FrontRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation
import FirebaseFirestore
import os
import Combine

class FrontRepository {
    private lazy var database = Firestore.firestore().collection("FrontRecords")
    private let logger = Logger(subsystem: "FrontRepository", category: "background")
    
    func listenForUserFrontRecords(userId: String) -> AsyncStream<[FrontRecord]> {
        return AsyncStream([FrontRecord].self) { cont in
            database
                .whereField("profileId", isEqualTo: userId)
                .order(by: "startTime", descending: true)
                .addSnapshotListener { snapshot, error in
                    if (error != nil) {
                        self.logger.error("Unable to get front records: \(error.debugDescription)")
                        cont.yield([])
                    }
                    
                    let frontRecords = snapshot?.documents.compactMap { record in
                        RepositoryUtils.decodeObject(FrontRecord.self, data: record.data())
                    }
                    cont.yield(frontRecords ?? [])
                }
        }
    }
    
    func getLastFrontRecordForAlter(alterId: String) async -> FrontRecord? {
        do {
            let documents = try await database
                .whereField("alterId", isEqualTo: alterId)
                .order(by: "startTime", descending: true)
                .limit(to: 1)
                .getDocuments()
            
            if (documents.isEmpty != false) {
                return nil
            }
            
            return RepositoryUtils.decodeObject(FrontRecord.self, data: (documents.documents.first?.data())!)
        } catch {
            logger.error("Unable to get alters: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveFrontRecord(frontRecord: FrontRecord) async {
        do {
            let foundRecord = database.document(frontRecord.id)
            let jsonData = RepositoryUtils.encodeObject(data: frontRecord)
            if (jsonData != nil) {
                try await foundRecord.setData(jsonData!, merge: true)
            }
        } catch {
            logger.error("Unabel to save front record: \(error.localizedDescription)")
        }
    }
}
