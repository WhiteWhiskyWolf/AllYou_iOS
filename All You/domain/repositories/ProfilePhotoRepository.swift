//
//  ProfilePhotoRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import FirebaseStorage
import os

class ProfilePhotoRepository {
    let logger = Logger(subsystem: "ProfilePhotoRepository", category: "background")
    let storage = Storage.storage().reference().child("ProfilePhotos")
    
    func getPhotoForId(id: String) async -> Data? {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                storage.child(id).getData(
                    maxSize: 5 * 1024 * 1024, // 5MB
                    completion: { data, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume(returning: data!)
                        }
                    })
            }
        } catch {
            logger.error("unable to get photo: \(error.localizedDescription)")
            return nil
        }
    }
    
    func createPhoto(id: String, data: Data) async {
        storage.child(id).putData(data, metadata: StorageMetadata(dictionary: ["contentType": "image/png"]))
    }
}
