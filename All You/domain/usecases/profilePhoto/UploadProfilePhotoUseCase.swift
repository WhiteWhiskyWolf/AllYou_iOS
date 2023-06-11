//
//  UploadProfilePhotoUseCase.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import Foundation

class UploadProfilePhotoUseCase {
    @Service var profilePhotoRepository: ProfilePhotoRepository
    
    func invoke(data: Data?, exisitngId: String?) async -> String {
        let id = exisitngId ?? UUID().uuidString
        if (data != nil) {
            await profilePhotoRepository.createPhoto(id: id, data: data!)
        }
        return id
    }
}
