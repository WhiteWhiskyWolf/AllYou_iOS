//
//  ProfilePhotoComponentReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation


struct ProfilePhotoComponentReducer {
    let reducer: Reducer<ProfilePhotoComponentState, ProfilePhotoComponentActions> = { state, action in
        switch(action) {
        case .LoadImage(imageId: let imageId):
            return ProfilePhotoComponentState.Loading
        case .LoadedImage(imageData: let imageData):
            return ProfilePhotoComponentState.Loaded(imageData: imageData)
        }
    }
}
