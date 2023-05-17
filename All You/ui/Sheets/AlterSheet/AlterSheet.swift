//
//  AlterSheet.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

struct AlterSheet: View {
    let alterId: String
    let store: Store<AlterSheetState, AlterSheetActions>
    
    init(alterId: String) {
        self.alterId = alterId
        self.store = Store(
            initialAction: .LoadAlter(alterId: alterId),
            initialState: AlterSheetState.Loading,
            reducer: AlterSheetReducer().reducer,
            sideEffects: AlterSheetSideEffects().sideEffects()
        )
    }
    
    var body: some View {
        AlterSheet_Internal(state: store.state, dispatch: store.dispatch)
    }
}

private struct AlterSheet_Internal: View {
    let state: AlterSheetState
    let dispatch: Dispatch<AlterSheetActions>
    
    var body: some View {
        switch(state) {
        case .Loading:
            LoadingAlterSheet()
        case .Loaeded(let alter, isCurrentUser: let isCurrentUser):
            if (isCurrentUser) {
                CurerntUserAlterSheet(
                    alter: alter,
                    dispatch: dispatch
                )
            } else {
                FriendAlterSheet(
                    alter: alter,
                    dispatch: dispatch
                )
            }
        }
    }
}

private struct LoadingAlterSheet: View {
    var body: some View {
        ProgressView()
    }
}

private struct CurerntUserAlterSheet: View {
    let alter: AlterUIModel
    let dispatch: Dispatch<AlterSheetActions>
    
    var body: some View {
        Text("Hello Curent USer")
    }
}

private struct FriendAlterSheet: View {
    let alter: AlterUIModel
    let dispatch: Dispatch<AlterSheetActions>
    
    var body: some View {
        Text("Hello Curent USer")
    }
}

struct AlterSheetCurrentUser_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AlterSheet_Internal(
                state: AlterSheetState.Loaeded(
                    alter: AlterUIModel(
                        id: "Test",
                        profileId: "test",
                        alterName: "Test Alter",
                        alterPronouns: "He/him",
                        alterDescription: "test des",
                        alterRole: "test role",
                        alterColor: "#4cdbe6",
                        alterProfilePhoto: nil,
                        isFronting: false,
                        frontingDate: Date.now
                    ),
                    isCurrentUser: true
                ),
                dispatch: { _ in }
            ).preferredColorScheme($0)
        }
    }
}


struct FriendsCurrentUser_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AlterSheet_Internal(
                state: AlterSheetState.Loaeded(
                    alter: AlterUIModel(
                        id: "Test",
                        profileId: "test",
                        alterName: "Test Alter",
                        alterPronouns: "He/him",
                        alterDescription: "test des",
                        alterRole: "test role",
                        alterColor: "#4cdbe6",
                        alterProfilePhoto: nil,
                        isFronting: false,
                        frontingDate: Date.now
                    ),
                    isCurrentUser: false
                ),
                dispatch: { _ in }
            ).preferredColorScheme($0)
        }
    }
}
