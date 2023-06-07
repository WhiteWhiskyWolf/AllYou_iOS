//
//  IsUserSignedInUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-21.
//

import Foundation


class IsUserSignedInUseCase {
    @Service var authenticationRepository: AuthenticationRepository
    
    func invoke() async -> Bool {
        return await self.authenticationRepository.isSignedIn()
    }
}
