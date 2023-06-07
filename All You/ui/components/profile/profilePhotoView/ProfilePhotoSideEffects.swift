//
//  ProfilePhotoSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-07.
//

import Foundation

class ProfilePhotoSideEffects {
    @Service var getProfilePhotoUseCase: GetProfilePhotoUseCase
    @Service var uploadPhotoUseCase: UploadProfilePhotoUseCase
    var onProfileIdChange: (String?) -> Void
    
    init(onProfileIdChange: @escaping (String?) -> Void) {
        self.onProfileIdChange = onProfileIdChange
    }
    
    func sideEffects() -> [SideEffect<ProfilePhotoState, ProfilePhotoActions>] {
        return [
            onLoadPhoto,
            onUploadPhoto
        ]
    }
    
    private func onLoadPhoto(
        oldState: ProfilePhotoState,
        newState: ProfilePhotoState,
        action: ProfilePhotoActions,
        dispatch: Dispatch<ProfilePhotoActions>
    ) async {
        if case .loadImage(id: let id) = action {
            let photoData = await getProfilePhotoUseCase.invoke(id: id)
            dispatch(ProfilePhotoActions.loadData(data: photoData))
        }
    }
    
    private func onUploadPhoto(
        oldState: ProfilePhotoState,
        newState: ProfilePhotoState,
        action: ProfilePhotoActions,
        dispatch: Dispatch<ProfilePhotoActions>
    ) async {
        if case .uploadImage(data: let data) = action {
            let id = await uploadPhotoUseCase.invoke(data: data, exisitngId: nil)
            onProfileIdChange(id)
        }
    }
}
