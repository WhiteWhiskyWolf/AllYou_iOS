//
//  SystemOnbaordingState.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-27.
//

import Foundation

struct SystemOnboardingState {
    let systemName: String
    let systemPronouns: String
    let systemProfilePhoto: String?
    let systemColor: String
    
    init() {
        self.systemName = ""
        self.systemPronouns = ""
        self.systemProfilePhoto = nil
        self.systemColor = "#8bda85"
    }
    
    init(systemName: String, systemPronouns: String, systemProfilePhoto: String?, systemColor: String) {
        self.systemName = systemName
        self.systemPronouns = systemPronouns
        self.systemProfilePhoto = systemProfilePhoto
        self.systemColor = systemColor
    }
    
    func copy(
        systemName: String? = nil,
        systemPronouns: String? = nil,
        systemProfilePhoto: String? = nil,
        systemColor: String? = nil
    ) -> SystemOnboardingState {
        return SystemOnboardingState(
            systemName: systemName ?? self.systemName,
            systemPronouns: systemPronouns ?? self.systemPronouns,
            systemProfilePhoto: systemProfilePhoto ?? self.systemProfilePhoto,
            systemColor: systemColor ?? self.systemColor
        )
    }
}
