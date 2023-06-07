//
//  ProfilePhotoReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

struct ProfilePhotoReducer {
    let reduer: Reducer<ProfilePhotoState, ProfilePhotoActions> = { state, action in
        switch(action) {
        case .loadImage(id: let id):
            return ProfilePhotoState.loading
        case .loadData(data: let data):
            return ProfilePhotoState.loadedData(imageData: data)
        case .uploadImage(data: let data):
            return ProfilePhotoState.loadedData(imageData: data)
        }
    }
}
