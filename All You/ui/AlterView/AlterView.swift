//
//  AlterView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-01.
//

import SwiftUI

struct AlterView: View {
    var body: some View {
        Text("Test")
    }
}

private struct AlterView_Internal: View {
    let state: AlterViewState
    var body: some View {
        let searchAlterBinding = Binding(get: {""}, set: {_ in })
        VStack {
            VStack {
                SearchBar(text: searchAlterBinding) {
                    ProfilePhotoComponent(
                        image: state.system.systemProfileImage,
                        name: state.system.systemName,
                        color: state.system.systemColor,
                        size: CGFloat(24)
                    )
                }
                Spacer()
                    .oneVertical()
                
                Text(state.system.systemName)
                    .font(.title)
                    .foregroundColor(Color.onPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if (!state.system.systemPronoun.isEmpty) {
                    Text("(\(state.system.systemPronoun))")
                        .font(.subheadline)
                        .foregroundColor(Color.onPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(Color.primaryColor)
            .cornerRadius(CGFloat(10))
            
            Spacer()
        
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

struct AlterView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AlterView_Internal(
                state: AlterViewState(
                    system: UserUIModel(
                        userId: "test",
                        systemName: "Test System Name",
                        systemPronoun: "He/Him",
                        systemColor: "#34c8a3",
                        systemProfileImage: nil
                    ),
                    alters: []
                )
            )
            .preferredColorScheme($0)
        }
    }
}
