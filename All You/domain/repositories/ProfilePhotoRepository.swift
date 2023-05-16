//
//  ProfilePhotoRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation
import Appwrite

class ProfilePhotoRepository {
    @Service var appwriteClient: AppwriteClient
    private lazy var storage: Storage = { Storage(appwriteClient.getClient()) }()
    private let profileBucket = "ProfilePhotos"
    
    func getPhotoForUser(id: String) async -> Data? {
        do {
            let file = try await storage.getFileDownload(bucketId: profileBucket, fileId: id)
            return Data(buffer: file)
        } catch {
            return nil
        }
    }
    
    func createPhoto(id: String, data: Data) async -> String? {
        do {
            let file = InputFile.fromData(data, filename: id, mimeType: "image/png")
            let result = try await storage.createFile(bucketId: profileBucket, fileId: id, file: file)
            return result.id
        } catch {
            return nil
        }
    }
    
    func deletePhoto(id: String) async {
        do {
            _ = try await storage.deleteFile(bucketId: profileBucket, fileId: id)
        } catch {
            
        }
    }
}
