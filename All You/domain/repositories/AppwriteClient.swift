//
//  AppwriteClient.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-20.
//

import Foundation
import Appwrite

struct AppwriteClient {
    
    func getDatabaseId() -> String {
        guard let filePath = Bundle.main.path(forResource: "Appwrite", ofType: "plist") else {
          fatalError("Couldn't find file 'Appwrite.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let databaseId = plist?.object(forKey: "DATABASE_ID") as? String else {
          fatalError("Couldn't find key 'DATABASE_ID' in 'TMDB-Info.plist'.")
        }
        return databaseId
    }
    
    func getUserRepisotry() -> String {
        guard let filePath = Bundle.main.path(forResource: "Appwrite", ofType: "plist") else {
          fatalError("Couldn't find file 'Appwrite.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let databaseId = plist?.object(forKey: "USER_REPO") as? String else {
          fatalError("Couldn't find key 'USER_REPO' in 'TMDB-Info.plist'.")
        }
        return databaseId
    }
    
    func getAlterRepisotry() -> String {
        guard let filePath = Bundle.main.path(forResource: "Appwrite", ofType: "plist") else {
          fatalError("Couldn't find file 'Appwrite.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let databaseId = plist?.object(forKey: "ALTER_REPO") as? String else {
          fatalError("Couldn't find key 'USER_REPO' in 'TMDB-Info.plist'.")
        }
        return databaseId
    }
    
    func getFrontRepisotry() -> String {
        guard let filePath = Bundle.main.path(forResource: "Appwrite", ofType: "plist") else {
          fatalError("Couldn't find file 'Appwrite.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let databaseId = plist?.object(forKey: "FRONT_REPO") as? String else {
          fatalError("Couldn't find key 'FRONT_REPO' in 'TMDB-Info.plist'.")
        }
        return databaseId
    }
    
    func getProfilePhotoBucket() -> String {
        guard let filePath = Bundle.main.path(forResource: "Appwrite", ofType: "plist") else {
          fatalError("Couldn't find file 'Appwrite.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let profilePhotoBucket = plist?.object(forKey: "PROFILE_PHOTO_BUCKET") as? String else {
          fatalError("Couldn't find key 'FRONT_REPO' in 'TMDB-Info.plist'.")
        }
        return profilePhotoBucket
    }
    
    func getClient() -> Client {
        guard let filePath = Bundle.main.path(forResource: "Appwrite", ofType: "plist") else {
          fatalError("Couldn't find file 'Appwrite.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let appwriteEndpoint = plist?.object(forKey: "APPWRITE_ENDPOINT") as? String else {
          fatalError("Couldn't find key 'APPWRITE_ENDPOINT' in 'TMDB-Info.plist'.")
        }
        guard let appwriteProject = plist?.object(forKey: "APPWRITE_PROJECT") as? String else {
          fatalError("Couldn't find key 'APPWRITE_PROJECT' in 'TMDB-Info.plist'.")
        }
        
        return Client()
            .setEndpoint(appwriteEndpoint)
            .setProject(appwriteProject)
    }
}

enum AppwriteError: Error {
    case InvalidCredentials
}
