//
//  ProfileViewComponent.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import SwiftUI
import PhotosUI

struct ProfileViewComponent: View {
    var profilePictureData: Data?
    var onPictueSelected: ( Data) -> Void
    
    @State private var selectedItem: PhotosPickerItem? = nil
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    if (profilePictureData != nil) {
                        Image(uiImage: UIImage(data: profilePictureData!)!)
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
                        if (newItem != nil) {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                onPictueSelected(data)
                            }
                        }
                    }
                }
            
            Spacer()
                .oneVertical()
            .clipShape(Capsule())
        }
    }
}
struct ProfileViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewComponent(
            onPictueSelected: { _ in }
        )
    }
}
