//
//  ProfilePhotoActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

enum ProfilePhotoActions {
    case loadImage(id: String?)
    case uploadImage(data: Data?)
    case loadData(data: Data?)
}
