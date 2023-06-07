//
//  ProfilePhotoComponent.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

struct ProfilePhotoComponent: View {
    let imageId: String?
    let name: String
    let color: String
    let size: CGFloat
    @ObservedObject var store: Store<ProfilePhotoComponentState, ProfilePhotoComponentActions>
    
    init(imageId: String?, name: String, color: String, size: CGFloat) {
        self.imageId = imageId
        self.name = name
        self.color = color
        self.size = size
        self.store = Store(
            initialAction: .LoadImage(imageId: imageId),
            initialState: .Loading,
            reducer: ProfilePhotoComponentReducer().reducer,
            sideEffects: ProfilePhotoComponentSideEffects().sideEffects()
        )
    }
    
    var body: some View {
        switch(store.state) {
        case .Loading:
            ProgressView()
        case .Loaded(imageData: let imageData):
            ProfilePhotoComponentLoaded(image: imageData, name: self.name, color: self.color, size: self.size)
        }
    }
}

private struct ProfilePhotoComponentLoaded: View {
    let image: Data?
    let name: String
    let color: String
    let size: CGFloat
    
    var body: some View {
        let initials = name.prefix(2).uppercased()
        ZStack {
            if (image != nil) {
                Image(uiImage: UIImage(data: image!)!)
                    .resizable()
            } else {
                GeometryReader { g in
                            ZStack {
                                Text(initials)
                                    .font(.system(size: size * 0.95))
                                    .modifier(FitToWidth())
                            }
                            .background(Color(hex: color))
                        }
            }
        }
        .overlay(
            Circle()
                .stroke(Color(hex: color), lineWidth: CGFloat(4))
        )
        .clipShape(Circle())
        .frame(width: size, height: size)
    }
}

struct FitToWidth: ViewModifier {
    var fraction: CGFloat = 1.0
    func body(content: Content) -> some View {
        GeometryReader { g in
            VStack {
                Spacer()
                content
                    .font(.system(size: 1000))
                    .minimumScaleFactor(0.005)
                    .lineLimit(1)
                    .frame(width: g.size.width * self.fraction)
                Spacer()
            }
        }
    }
}

struct ProfilePhotoComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoComponentLoaded(
            image: nil,
            name: "Cate",
            color: "#01e153",
            size: CGFloat(24)
        )
    }
}
