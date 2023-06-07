//
//  ProfilePhotoComponentActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

enum ProfilePhotoComponentActions{
    case LoadImage(imageId: String?)
    case LoadedImage(imageData: Data?)
}
