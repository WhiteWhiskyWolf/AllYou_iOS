//
//  AuthenticationRepository.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-19.
//

import Foundation
import Appwrite

class AuthenticationRepository {
    @Service var appwriteClient: AppwriteClient
    private lazy var account: Account = { Account(appwriteClient.getClient()) }()
    
    func getUserId() async -> String? {
        do {
            let account = try await account.get()
            return account.id
        } catch {
            return nil
        }
    }
    
    func isSignedIn() async -> Bool {
        do {
            try _ = await account.get()
            return true
        } catch {
            return false
        }
    }
    
    func signInWtihApple() async -> Bool {
        do {
            return try account.createOAuth2Session(provider: "apple")
        } catch {
            return false
        }
    }
    
    func signInWithGoogle() async -> Bool {
        do {
            return try account.createOAuth2Session(provider: "google")
        } catch {
            return false
        }
    }
}
