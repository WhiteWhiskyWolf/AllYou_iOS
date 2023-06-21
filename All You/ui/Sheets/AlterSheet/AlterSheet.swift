//
//  AlterSheet.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

struct AlterSheet: View {
    let alterId: String
    let onClose: () -> Void
    @ObservedObject var store: Store<AlterSheetState, AlterSheetActions>
    
    init(alterId: String, onClose: @escaping () -> Void) {
        self.alterId = alterId
        self.onClose = onClose
        self.store = Store(
            initialAction: .LoadAlter(alterId: alterId),
            initialState: AlterSheetState.Loading,
            reducer: AlterSheetReducer().reducer,
            sideEffects: AlterSheetSideEffects().sideEffects()
        )
    }
    
    var body: some View {
        AlterSheet_Internal(
            state: store.state,
            dispatch: store.dispatch,
            onClose: onClose
        )
    }
}

private struct AlterSheet_Internal: View {
    let state: AlterSheetState
    let dispatch: Dispatch<AlterSheetActions>
    let onClose: () -> Void
    
    var body: some View {
        switch(state) {
        case .Loading:
            LoadingAlterSheet()
        case .Loaded(
            alter: let alter,
            host: let host,
            isCurrentUser: let isCurrentUser,
            displayHostSelection: let displayHostSelection):
            let hostPopupBinding = Binding<Bool>(
                get: {displayHostSelection},
                set: {_ in dispatch(AlterSheetActions.SelectedHost(alterId: ""))}
            )
            if (isCurrentUser) {
                CurerntUserAlterSheet(
                    alter: alter,
                    alterHost: host,
                    dispatch: dispatch,
                    onClose: onClose
                ).popover(isPresented: hostPopupBinding) {
                    HostPopup(
                        onHostSelected: {hostId in
                            dispatch(AlterSheetActions.SelectedHost(alterId: hostId))
                        }
                    )
                }
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
    let alterHost: AlterUIModel?
    let dispatch: Dispatch<AlterSheetActions>
    let onClose: () -> Void
    
    var body: some View {
        let alterNameBinding = Binding(
            get: {
                alter.alterName ?? ""
            },
            set: { newName in
                dispatch(AlterSheetActions.UpdateName(name: newName))
            }
        )
        let pronounBinding = Binding(
            get: {alter.alterPronouns ?? ""},
            set: { newPronouns in
                dispatch(AlterSheetActions.UpdatePronouns(pronouns: newPronouns))
            }
        )
        let colorBinding = Binding(
            get: {Color(hex: alter.alterColor)},
            set: { dispatch(AlterSheetActions.UpdateColor(color: $0.hexString())) }
        )
        let descriptionBinding = Binding(
            get: {alter.alterDescription ?? ""},
            set: {dispatch(AlterSheetActions.UpdateDescription(description: $0))}
        )
        let roleBinding = Binding(
            get: {alter.alterRole ?? ""},
            set: {dispatch(AlterSheetActions.UpdateRole(role: $0))}
        )
        VStack(alignment: .leading) {
            HStack {
                ProfileViewComponent(
                    onPictueSelected: { data in
                        dispatch(AlterSheetActions.UpdatePhotoId(photoId: data))
                    },
                    photoId: alter.alterProfilePhoto
                )
                
                Spacer()
                    .oneHorizontal()
                
                VStack {
                    TextField("Alter Name", text: alterNameBinding, axis: .horizontal)
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .previewLayout(.sizeThatFits)
                    
                    TextField("Alter Pronouns", text: pronounBinding, axis: .horizontal)
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .previewLayout(.sizeThatFits)
                }
            }
            
            ColorPicker("Alter Color", selection: colorBinding)
            
            Spacer()
                .oneVertical()
            
            Text("Host")
            HStack {
                if (alterHost == nil ) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                } else {
                    ProfilePhotoComponent(
                        imageId: alterHost!.alterProfilePhoto,
                        name: alterHost!.alterName ?? "",
                        color: alterHost!.alterColor,
                        size: CGFloat(30)
                    )
                    Spacer()
                        .oneHorizontal()
                    Text(alterHost?.alterName ?? "Host Alter")
                }
            }
            .onTapGesture {
                dispatch(AlterSheetActions.SelectHost)
            }
            
            VStack {
                Spacer()
                    .oneVertical()
                
                TextField("Alter Description", text: descriptionBinding, axis: .horizontal)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .previewLayout(.sizeThatFits)
                
                Spacer()
                    .oneVertical()
                
                TextField("Alter Role", text: roleBinding, axis: .horizontal)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .previewLayout(.sizeThatFits)
                
                Spacer()
                
                Button(
                    action: {
                        dispatch(AlterSheetActions.SplitAlter)
                    },
                    label: {Text("Split")}
                ).buttonStyle(PrimaryButton())
                
                Spacer()
                    .oneVertical()
                
                Button(
                    action: {
                        dispatch(AlterSheetActions.SaveAlter)
                        onClose()
                    },
                    label: {Text("Save")}
                ).buttonStyle(PrimaryButton())
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
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
                state: AlterSheetState.Loaded(
                    alter: AlterUIModel(
                        id: "Test1",
                        profileId: "test",
                        hostId: nil,
                        alterName: "Test Alter",
                        alterPronouns: "He/him",
                        alterDescription: "test des",
                        alterRole: "test role",
                        alterColor: "#4cdbe6",
                        alterProfilePhoto: nil,
                        isFronting: false,
                        frontingDate: Date.now
                    ),
                    host: AlterUIModel(
                        id: "Test2",
                        profileId: "test",
                        hostId: nil,
                        alterName: "Test Alter",
                        alterPronouns: "He/him",
                        alterDescription: "test des",
                        alterRole: "test role",
                        alterColor: "#4cdbe6",
                        alterProfilePhoto: nil,
                        isFronting: false,
                        frontingDate: Date.now
                    ),
                    isCurrentUser: true,
                    displayHostSelection: false
                ),
                dispatch: { _ in },
                onClose: {}
            ).preferredColorScheme($0)
        }
    }
}


struct FriendsCurrentUser_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AlterSheet_Internal(
                state: AlterSheetState.Loaded(
                    alter: AlterUIModel(
                        id: "Test1",
                        profileId: "test",
                        hostId: nil,
                        alterName: "Test Alter",
                        alterPronouns: "He/him",
                        alterDescription: "test des",
                        alterRole: "test role",
                        alterColor: "#4cdbe6",
                        alterProfilePhoto: nil,
                        isFronting: false,
                        frontingDate: Date.now
                    ),
                    host: AlterUIModel(
                        id: "Test2",
                        profileId: "test",
                        hostId: nil,
                        alterName: "Test Alter",
                        alterPronouns: "He/him",
                        alterDescription: "test des",
                        alterRole: "test role",
                        alterColor: "#4cdbe6",
                        alterProfilePhoto: nil,
                        isFronting: false,
                        frontingDate: Date.now
                    ),
                    isCurrentUser: false,
                    displayHostSelection: false
                ),
                dispatch: { _ in },
                onClose: {}
            ).preferredColorScheme($0)
        }
    }
}
