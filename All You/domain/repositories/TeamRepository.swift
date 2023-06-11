//
//  TeamRepository.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-09.
//

import Foundation
import Appwrite
import os

class TeamRepository {
    @Service var appwriteClient: AppwriteClient
    private lazy var teams: Teams = { Teams(appwriteClient.getClient()) }()
    private let logger = Logger(subsystem: "TeamRepository", category: "background")
    
    func createTeam(userId: String) async {
        do {
            _ = try await teams.create(teamId: userId, name: userId)
        } catch {
            logger.error("Unable to create team \(String(describing: error))")
        }
    }
}
