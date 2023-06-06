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
        systemImage: Data?,
        isSignlet: Bool,
        alterName: String,
        alterPronouns: String,
        alterColor: String,
        alterImage: Data?,
        alterDescription: String?,
        alterRole: String?
    ) async {
        let userId = await authenticationRepository.getUserId() ?? UUID().uuidString
        var profilePhotoId = ""
        if (systemImage != nil) {
            let id = UUID().uuidString
            profilePhotoId = await profilePhotoReposiotry.createPhoto(id: id, data: systemImage!) ?? ""
        }
        let userModel = UserModel(
            userId: userId,
            systemName: systemName,
            systemPronoun: systemPronouns,
            systemColor: systemColor,
            systemProfileId: profilePhotoId
        )
        await userRepository.saveUser(userModel: userModel)
        if (isSignlet) {
            let alterModel = AlterModel(
                id: UUID().uuidString,
                profileId: userModel.userId,
                alterName: systemName,
                alterPronouns: systemPronouns,
                alterDescription: nil,
                alterRole: nil,
                alterColor: systemColor,
                alterProfilePhoto: profilePhotoId
            )
            await alterRepository.saveAlter(alterModel: alterModel)
        } else {
            var alterProfileId = ""
            if (alterImage != nil) {
                let id = UUID().uuidString
                alterProfileId = await profilePhotoReposiotry.createPhoto(id: id, data: systemImage!) ?? ""
            }
            let alterModel = AlterModel(
                id: UUID().uuidString,
                profileId: userModel.userId,
                alterName: alterName,
                alterPronouns: alterPronouns,
                alterDescription: alterDescription,
                alterRole: alterRole,
                alterColor: alterPronouns,
                alterProfilePhoto: alterProfileId
            )
            await alterRepository.saveAlter(alterModel: alterModel)
        }
    }
}
