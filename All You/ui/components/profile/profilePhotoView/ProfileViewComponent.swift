//
//  ProfileViewComponent.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import SwiftUI
import PhotosUI

struct ProfileViewComponent: View {
    @ObservedObject var store: Store<ProfilePhotoState, ProfilePhotoActions>
    var onPictueSelected: (String?) -> Void
    
    init(onPictueSelected: @escaping (String?) -> Void, photoId: String?) {
        self.onPictueSelected = onPictueSelected
        self.store = Store(
            initialAction: .loadImage(id: photoId),
            initialState: .loading,
            reducer: ProfilePhotoReducer().reduer,
            sideEffects: ProfilePhotoSideEffects(
                onProfileIdChange: onPictueSelected
            ).sideEffects()
        )
    }
    
    var body: some View {
        switch(store.state) {
        case .loading:
            ProgressView()
        case .loadedData(imageData: let data):
            ProfileVieCompontentLoaded(
                photoData: data,
                dispatch: store.dispatch
            )
        }
    }
}

private struct ProfileVieCompontentLoaded: View {
    let photoData: Data?
    let dispatch: Dispatch<ProfilePhotoActions>
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    if (photoData != nil) {
                        Image(uiImage: UIImage(data: photoData!)!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            dispatch(ProfilePhotoActions.uploadImage(data: data))
                        }
                    }
                }
            
            Spacer()
                .oneVertical()
            .clipShape(Capsule())
        }
    }
}
