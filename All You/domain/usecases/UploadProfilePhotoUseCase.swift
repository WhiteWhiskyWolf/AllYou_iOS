//
//  UploadProfilePhotoUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation

class UploadProfilePhotoUseCase {
    @Service var profilePhotoRepository: ProfilePhotoRepository
    
    func invoke(data: Data, exisitngId: String?) async -> String? {
        if (exisitngId?.isEmpty == false) {
            await profilePhotoRepository.deletePhoto(id: exisitngId!)
        }
        
        return await profilePhotoRepository.createPhoto(id: exisitngId ?? UUID().uuidString, data: data)
    }
}
