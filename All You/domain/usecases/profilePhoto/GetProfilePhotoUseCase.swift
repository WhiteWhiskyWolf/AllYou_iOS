//
//  GetProfilePhotoUseCase.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

class GetProfilePhotoUseCase {
    @Service var profilePhotoRepository: ProfilePhotoRepository
    
    func invoke(id: String?) async -> Data? {
        if (id?.isEmpty != false) {
            return nil
        }
        
        return await profilePhotoRepository.getPhotoForId(id: id!)
    }
}
