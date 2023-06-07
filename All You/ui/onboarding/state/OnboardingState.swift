//
//  OnboardingState.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation

struct OnboardingState {
    let page: Int
    let displaySelectPhoto: Bool
    let displaySelectColor: Bool
    
    let systemName: String
    let systemPronouns: String
    let systemColor: String
    let systemImage: String?
    
    let isSignlet: Bool
    
    let alterName: String
    let alterPronouns: String
    let alterColor: String
    let alterImage: String?
    let alterDescription: String?
    let alterRole: String?
    
    init() {
        self.page = 0
        self.displaySelectColor = false
        self.displaySelectPhoto = false

        self.systemName = ""
        self.systemPronouns = ""
        self.systemColor = "#ab6856"
        self.systemImage = nil
        
        self.isSignlet = false

        self.alterName = ""
        self.alterPronouns = ""
        self.alterDescription = nil
        self.alterColor = "#ab6856"
        self.alterImage = nil
        self.alterRole = nil
    }
    
    init(
        page: Int,
        displaySelectPhoto: Bool,
        displaySelectColor: Bool,
        systemName: String,
        systemPronouns: String,
        systemColor: String,
        systemImage: String?,
        isSignlet: Bool,
        alterName: String,
        alterPronouns: String,
        alterColor: String,
        alterImage: String?,
        alterDescription: String?,
        alterRole: String?
    ) {
        self.page = page
        self.displaySelectColor = displaySelectColor
        self.displaySelectPhoto = displaySelectPhoto
        self.systemName = systemName
        self.systemPronouns = systemPronouns
        self.systemColor = systemColor
        self.systemImage = systemImage
        self.isSignlet = isSignlet
        self.alterName = alterName
        self.alterPronouns = alterPronouns
        self.alterColor = alterColor
        self.alterImage = alterImage
        self.alterDescription = alterDescription
        self.alterRole = alterRole
    }
    
    func copy(
        page: Int? = nil,
        displaySelectPhoto: Bool? = nil,
        displaySelectColor: Bool? = nil,
        systemName: String? = nil,
        systemPronouns: String? = nil,
        systemColor: String? = nil,
        systemImage: String? = nil,
        isSignlet: Bool? = nil,
        alterName: String? = nil,
        alterPronouns: String? = nil,
        alterColor: String? = nil,
        alterImage: String? = nil,
        alterDescription: String? = nil,
        alterRole: String? = nil
    ) -> OnboardingState {
        return OnboardingState(
            page: page ?? self.page,
            displaySelectPhoto: displaySelectPhoto ?? self.displaySelectColor,
            displaySelectColor: displaySelectColor ?? self.displaySelectColor,
            systemName: systemName ?? self.systemName,
            systemPronouns: systemPronouns ?? self.systemPronouns,
            systemColor: systemColor ?? self.systemColor,
            systemImage: systemImage ?? self.systemImage,
            isSignlet: isSignlet ?? self.isSignlet,
            alterName: alterName ?? self.alterName,
            alterPronouns: alterPronouns ?? self.alterPronouns,
            alterColor: alterColor ?? self.alterColor,
            alterImage: alterImage ?? self.alterImage,
            alterDescription: alterDescription ?? self.alterDescription,
            alterRole: alterRole ?? self.alterRole
        )
    }
}

