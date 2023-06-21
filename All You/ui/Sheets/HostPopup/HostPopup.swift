//
//  HostPopup.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import SwiftUI

struct HostPopup: View {
    let onHostSelected: (String) -> Void
    @ObservedObject var store: Store<HostPopupState, HostPopupActions>
    
    init(onHostSelected: @escaping (String) -> Void) {
        self.onHostSelected = onHostSelected
        self.store = Store(
            initialAction: .loadAlters,
            initialState: HostPopupState(searchString: "", alters: []),
            reducer: HostPopupReducer().reducer,
            sideEffects: HostPopupSideEffects().sideEffects()
        )
    }
    
    var body: some View {
        HostPopup_Internal(
            onHostSelected: onHostSelected,
            state: store.state,
            dispatch: store.dispatch
        )
    }
    
}

private struct HostPopup_Internal: View {
    let onHostSelected: (String) -> Void
    let state: HostPopupState
    let dispatch: Dispatch<HostPopupActions>
    
    var body: some View {
        let searchBinding = Binding(
            get: {state.searchString},
            set: {dispatch(HostPopupActions.searchAlter(searchString: $0))}
        )
        VStack {
            HStack {
                SearchBar(text: searchBinding) {}
                Button(action: {onHostSelected("")}, label: {Text("clear")})
            }
            LazyVStack(alignment: .leading) {
                ForEach(state.alters, id: \.id) { alter in
                    HStack {
                        ProfilePhotoComponent(
                            imageId: alter.alterProfilePhoto,
                            name: alter.alterName ?? "",
                            color: alter.alterColor,
                            size: CGFloat(30)
                        )
                        
                        Spacer()
                            .oneHorizontal()
                        
                        Text(alter.alterName ?? "")
                            .font(.body)
                        
                        Spacer()
                            .oneHorizontal()
                        
                        Text("(\(alter.alterPronouns ?? ""))")
                            .font(.body)
                    }
                    .onTapGesture {
                        onHostSelected(alter.id)
                    }
                }
            
            }
        }
        .padding()
    }
}

struct HostPopup_Previews: PreviewProvider {
    static var previews: some View {
        HostPopup_Internal(
            onHostSelected: { _ in },
            state: HostPopupState(
                searchString: "test",
                alters: [
                    AlterUIModel(
                        id: "test1",
                        profileId: "test",
                        hostId: nil,
                        alterName: "Test Alter",
                        alterPronouns: "He/Him",
                        alterDescription: "Test des",
                        alterRole: "test role",
                        alterColor: "#4cdbe6",
                        alterProfilePhoto: nil,
                        isFronting: false,
                        frontingDate: Date.now
                    ),
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
                ]
            ),
            dispatch: { _ in }
        )
    }
}
