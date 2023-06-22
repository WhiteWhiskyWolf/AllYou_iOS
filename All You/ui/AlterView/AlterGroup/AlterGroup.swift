//
//  AlterGroup.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-21.
//

import SwiftUI

struct AlterGroup: View {
    let rootAlter: AlterUIModel
    @ObservedObject var store: Store<AlterGroupState, AlterGroupActions>
    
    init(rootAlter: AlterUIModel) {
        self.rootAlter = rootAlter
        self.store = Store(
            initialAction: .loadAlter(alter: rootAlter),
            initialState: .loading,
            reducer: AlterGroupReducer().reducer,
            sideEffects: AlterGroupSideEffects().sideEffects()
        )
    }
    var body: some View {
        AlterGroup_Internal(state: store.state, dispatch: store.dispatch)
    }
}

private struct AlterGroup_Internal: View {
    let state: AlterGroupState
    let dispatch: Dispatch<AlterGroupActions>
    
    var body: some View {
        if case .loaded(let alter, let subAlters, let expanded) = state {
            VStack {
                HStack {
                    ProfilePhotoComponent(
                        imageId: alter.alterProfilePhoto,
                        name: alter.alterName ?? "Alter",
                        color: alter.alterColor,
                        size: CGFloat(30)
                    )
                    
                    Spacer()
                        .oneHorizontal()
                    
                    Text(alter.alterName ?? "Alter")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    if (subAlters.count > 0) {
                        Button(action: {
                            dispatch(.toggleExpanded)
                        }) {
                            Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        }
                    }
                }
                
                Spacer()
                    .oneVertical()
                
                if (expanded) {
                    ForEach(subAlters, id: \.id) { alter in
                        AlterGroup(rootAlter: alter)
                        
                        Spacer()
                            .oneVertical()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .transition(.move(edge: .bottom))
        }
    }
}

struct AlterGroup_Previews: PreviewProvider {
    static var previews: some View {
        AlterGroup_Internal(
            state: .loaded(
                alter: AlterUIModel(
                    id: "test",
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
                subAlters: [
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
                        frontingDate: Date.now
                    ),
                    AlterUIModel(
                        id: "test3",
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
                    )
                ],
                expanded: true
            ),
            dispatch: {_ in }
        )
    }
}
