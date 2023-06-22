//
//  AlterView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

struct AlterView: View {
    @ObservedObject var store: Store<AlterViewState, AlterViewActions> = Store(
        initialAction: .loadCurrentUser,
        initialState: AlterViewState.loading,
        reducer: AlterViewReducer().reducer,
        sideEffects: AlterViewSideEffects().sideEffects()
    )
    
    var body: some View {
        AlterView_Internal(state: store.state, dispatch: store.dispatch)
    }
}

private struct AlterView_Internal: View {
    let state: AlterViewState
    let dispatch: (AlterViewActions) -> Void
    
    var body: some View {
        VStack {
            switch(state) {
            case .loading:
                ProgressView()
            case .loaded(
                system: let system,
                alters: let alters,
                search: let search,
                filteredAlters: let filteredAlters):
                AlterViewLoaded(
                    system: system,
                    alters: alters,
                    search: search,
                    filteredAlters: filteredAlters,
                    dispatch: dispatch
                )
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct AlterViewLoaded: View {
    let system: UserUIModel
    let alters: [AlterUIModel]
    let search: String?
    let filteredAlters: [AlterUIModel]
    let dispatch: (AlterViewActions) -> Void
    
    var body: some View {
        let searchAlterBinding = Binding(
            get: {search ?? ""},
            set: {dispatch(AlterViewActions.searchAlters(search: $0))}
        )
        VStack {
            VStack {
                SearchBar(text: searchAlterBinding) {
                    ProfilePhotoComponent(
                        imageId: system.systemProfileImage,
                        name: system.systemName,
                        color: system.systemColor,
                        size: CGFloat(24)
                    )
                }
                Spacer()
                    .oneVertical()
                
                Text(system.systemName)
                    .font(.title)
                    .foregroundColor(Color.onPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if (!system.systemPronoun.isEmpty) {
                    Text("(\(system.systemPronoun))")
                        .font(.subheadline)
                        .foregroundColor(Color.onPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(Color.primaryColor)
            .cornerRadius(CGFloat(10))
            
            Spacer()
                .oneVertical()
            
            if (search?.isEmpty != false) {
                ScrollView {
                    ForEach(alters, id: \.id) { alter in
                        AlterGroup(rootAlter: alter)
                        Divider()
                    }
                    
                }
            } else {
                ScrollView {
                    ForEach(filteredAlters) { alter in
                        AlterGroup(rootAlter: alter)
                        Divider()
                    }
                }
            }
            
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
                state: AlterViewState.loaded(
                    system: UserUIModel(
                        userId: "test",
                        systemName: "Test System",
                        systemPronoun: "she/they",
                        systemColor: "#4cdbe6",
                        systemProfileImage: nil
                    ),
                    alters: [
                        AlterUIModel(
                            id: "test2",
                            profileId: "test",
                            hostId: nil,
                            alterName: "Test Alter",
                            alterPronouns: "He/Him",
                            alterDescription: "Test des",
                            alterRole: "test role",
                            alterColor: "#4cdbe6",
                            alterProfilePhoto: nil,
                            isFronting: false,
                            frontingDate: nil
                        ),
                    ],
                    search: nil,
                    filteredAlters: []
                ),
                dispatch: {_ in}
            )
            .preferredColorScheme($0)
        }
    }
}
