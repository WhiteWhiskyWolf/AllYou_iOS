//
//  ThreadRepository.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-22.
//

import Foundation
import FirebaseFirestore
import os
import AsyncAlgorithms

class ThreadRepository {
    private lazy var database = Firestore.firestore().collection("Threads")
    private let logger = Logger(subsystem: "ThreadsRepository", category: "background")
    
    // MARK: - getthreadsForAlters
    func getThreadsForAlters(alterIds: [String]) async -> AsyncStream<[ThreadModel]> {
        return AsyncStream([ThreadModel].self) { cont in
            database
                .whereField("participantAlterIds", arrayContainsAny: alterIds)
                .order(by: "lastMessageTime", descending: true)
                .addSnapshotListener { snapshot, error in
                    if (error != nil) {
                        self.logger.error("Unable to get threads: \(error.debugDescription)")
                        cont.yield([])
                    }
                    
                    let threads: [ThreadModel] = snapshot?.documents.compactMap { record in
                        RepositoryUtils.decodeObject(ThreadModel.self, data: record.data())
                    } ?? []
                    cont.yield(threads)
                }
        }
    }
    
    // MARK: - saveThread
    func saveThread(threadModel: ThreadModel) async {
        do {
            let foundthread = database.document(threadModel.threadId)
            let jsonData = RepositoryUtils.encodeObject(data: threadModel)
            if (jsonData != nil) {
                try await foundthread.setData(jsonData!, merge: true)
            }
        } catch {
            logger.error("Unabel to save thread: \(error.localizedDescription)")
        }
    }
    
}
