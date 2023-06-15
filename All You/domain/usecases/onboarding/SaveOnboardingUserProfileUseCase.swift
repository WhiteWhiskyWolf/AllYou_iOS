//
//  SaveUserProfileUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation


class SaveOnboardingUserProfileUseCase {
    @Service var userRepository: UserRepsoitory
    @Service var profilePhotoReposiotry: ProfilePhotoRepository
    @Service var alterRepository: AlterRepository
    @Service var authenticationRepository: AuthenticationRepository
    
    func invoke(
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
    ) async {
        if let authenticationId = await authenticationRepository.getUserId() {
            let userId = await authenticationRepository.getUserId() ?? UUID().uuidString
            
            let userModel = UserModel(
                userId: userId,
                systemName: systemName,
                systemPronoun: systemPronouns,
                systemColor: systemColor,
                systemProfileId: systemImage
            )
            await userRepository.saveUser(userModel: userModel)
            
            if (isSignlet) {
                let alterModel = AlterModel(
                    id: UUID().uuidString,
                    profileId: userModel.userId,
                    hostId: nil,
                    alterName: systemName,
                    alterPronouns: systemPronouns,
                    alterDescription: nil,
                    alterRole: nil,
                    alterColor: systemColor,
                    alterProfilePhoto: alterImage
                )
                await alterRepository.saveAlter(alterModel: alterModel, userId: authenticationId)
            } else {
                let alterModel = AlterModel(
                    id: UUID().uuidString,
                    profileId: userModel.userId,
                    hostId: nil,
                    alterName: alterName,
                    alterPronouns: alterPronouns,
                    alterDescription: alterDescription,
                    alterRole: alterRole,
                    alterColor: alterPronouns,
                    alterProfilePhoto: alterImage
                )
                await alterRepository.saveAlter(alterModel: alterModel, userId: authenticationId)
            }
        }
    }
}
