//
//  GetVisibleSystemsUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-23.
//

import Foundation

class GetVisibleSystemsUseCase {
    @Service var authenticationRepository: AuthenticationRepository
    @Service var userRepisotry: UserRepsoitory
    
    func invoke() async -> [UserUIModel] {
        // TODO add friends search
        if let currentUser = await authenticationRepository.getUserId() {
            let currentSystem = await userRepisotry.getUser(userId: currentUser)
            return [UserUIModel(userModel: currentSystem!)]
        } else {
            return []
        }
    }

}
