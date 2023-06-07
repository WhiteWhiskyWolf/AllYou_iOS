//
//  ProfilePhotoComponentSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

class ProfilePhotoComponentSideEffects {
    @Service var getPhotoUseCase: GetProfilePhotoUseCase
    
    func sideEffects() -> [SideEffect<ProfilePhotoComponentState, ProfilePhotoComponentActions>] {
        return [
            onLoadPhoto,
        ]
    }
    
    private func onLoadPhoto(
        oldState: ProfilePhotoComponentState,
        newState: ProfilePhotoComponentState,
        action: ProfilePhotoComponentActions,
        dispatch: Dispatch<ProfilePhotoComponentActions>
    ) async {
        if case .LoadImage(imageId: let id) = action {
            let photoData = await getPhotoUseCase.invoke(id: id)
            dispatch(ProfilePhotoComponentActions.LoadedImage(imageData: photoData))
        }
    }
}
