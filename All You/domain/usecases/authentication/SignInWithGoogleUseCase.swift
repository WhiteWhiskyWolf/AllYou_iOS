//
//  SignInWithGoogleUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-24.
//

import Foundation

class SignInWithGoogleUseCase {
    @Service var authenticationRepository: AuthenticationRepository
    
    func invoke() async  -> Bool {
        return await authenticationRepository.signInWithGoogle()
    }
}
