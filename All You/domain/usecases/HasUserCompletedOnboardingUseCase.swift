//
//  HasUserCompletedOnboardingUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-26.
//

import Foundation

class HasUseCompletedOnboardingUseCase {
    @Service var authenticationRepository: AuthenticationRepository
    @Service var userRepository: UserRepsoitory
    
    func invoke() async -> Bool {
        if let userId = await authenticationRepository.getUserId() {
            return await userRepository.getUser(userId: userId) != nil
        } else {
            return false
        }
    }
}
