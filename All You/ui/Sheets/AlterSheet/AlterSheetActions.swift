//
//  AlterSheetActions.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

enum AlterSheetActions {
    case LoadAlter(alterId: String)
    case LoaedAlter(alter: AlterUIModel, isCurrentUser: Bool, host: AlterUIModel?)
    case UploadPhoto(alterId: String, alterPhoto: Data)
    case UpdatePhotoId(photoId: String?)
    case UpdateName(name: String)
    case UpdatePronouns(pronouns: String)
    case UpdateColor(color: String)
    case UpdateDescription(description: String)
    case UpdateRole(role: String)
    case SplitAlter
    case SaveAlter
    case SelectHost
    case SelectedHost(alterId: String)
}
