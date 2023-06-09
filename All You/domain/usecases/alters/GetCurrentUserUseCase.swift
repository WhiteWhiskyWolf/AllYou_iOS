//
//  GetCurrentUserUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

class GetCurrentUserUseCase {
    @Service var authenticationRepository: AuthenticationRepository
    @Service var userRepsository: UserRepsoitory
    @Service var profilePhotoRepository: ProfilePhotoRepository
    
    func invoke() async -> UserUIModel? {
        if let userId = await authenticationRepository.getUserId() {
            let foundUser = await userRepsository.getUser(userId: userId)
            if (foundUser == nil) {
                return nil
            }
            return UserUIModel(userModel: foundUser!)
        } else {
            return nil
        }
    }
}
