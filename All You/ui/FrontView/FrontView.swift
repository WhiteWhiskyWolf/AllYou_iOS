//
//  FrontView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

struct FrontView: View {
    @ObservedObject var store: Store<FrontState, FrontActions>
    
    init() {
        self.store = Store(
            initialAction: .LoadCurrentUser,
            initialState: FrontState.Loading,
            reducer: FrontReducer().reducer,
            sideEffects: FrontSideEffects().sideEffects()
        )
    }
    
    var body: some View {
        FrontView_Internal(state: store.state, dispatch: store.dispatch)
    }
}

private struct FrontView_Internal: View {
    let state: FrontState
    let dispatch: Dispatch<FrontActions>
    
    var body: some View {
        switch(state) {
        case .Loading:
            ProgressView()
        case .Loaded(let searchString, let isCurrentUser, let selectedAlter, let selectedSystem, let alters):
            FrontView_Loaded(
                searchString: searchString,
                isCurrentUser: isCurrentUser,
                selectedAlter: selectedAlter,
                selectedSystem: selectedSystem,
                alters: alters,
                dispatch: dispatch
            )
        }
    }
}

private struct FrontView_Loaded: View {
    let searchString: String
    let isCurrentUser: Bool
    let selectedAlter: String?
    let selectedSystem: UserUIModel
    let alters: [AlterUIModel]
    let dispatch: Dispatch<FrontActions>
    
    var body: some View {
        let searchBinding = Binding(
            get: {searchString},
            set: {dispatch(FrontActions.SearchAlter(searchString: $0))}
        )
        let selectedAlterBinding = Binding(
            get: {selectedAlter != nil},
            set: { shouldClose in
                if (!shouldClose) {
                    dispatch(FrontActions.CloseAlter)
                }
            }
        )
        
        ScrollView {
            VStack(alignment: .leading) {
                SearchBar(text: searchBinding) {
                    ProfilePhotoComponent(
                        imageId: selectedSystem.systemProfileImage,
                        name: selectedSystem.systemName,
                        color: selectedSystem.systemColor,
                        size: CGFloat(24)
                    )
                }
                Spacer()
                    .oneVertical()
                
                Text(selectedSystem.systemName)
                    .font(.title)
                    .foregroundColor(Color.onPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.primaryColor)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            
            Spacer()
                .oneVertical()
            
            LazyVStack {
                FrontAltersView(
                    upFrontAlters: alters.filter { alter in
                        alter.isFronting
                    },
                    dispatch: dispatch
                )
                
                Spacer()
                    .oneVertical()
                
                OtherAltersView(
                    otherAlters: alters.filter { alter in
                        !alter.isFronting
                    },
                    dispatch: dispatch
                )
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .sheet(
            isPresented: selectedAlterBinding,
            content: {
                AlterSheet(alterId: selectedAlter!) {
                    dispatch(FrontActions.CloseAlter)
                }
            }
        )
    }
}

private struct OtherAltersView: View {
    let otherAlters: [AlterUIModel]
    let dispatch: Dispatch<FrontActions>
    
    var body: some View {
        VStack {
            HStack {
                Text("Other Alters")
                    .font(.title)
                    .foregroundColor(Color.onBackground)
                Spacer()
                Button(
                    action: {dispatch(FrontActions.SelectAlter(alterId: ""))},
                    label: {
                        Text("New Alter")
                            .font(.caption)
                    }
                )
                .buttonStyle(PrimaryButtonSmall())
            }
            
            Divider()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(otherAlters) { alter in
                    AlterCard(alter: alter, dispatch: dispatch)
                }
            }
        }
    }
}

private struct AlterCard: View {
    let alter: AlterUIModel
    let dispatch: Dispatch<FrontActions>
    
    var body: some View {
        VStack {
            HStack {
                ProfilePhotoComponent(
                    imageId: alter.alterProfilePhoto,
                    name: alter.alterName ?? "",
                    color: alter.alterColor,
                    size: CGFloat(36)
                )

                Spacer()
                    .oneHorizontal()

                VStack{
                    Text(alter.alterName ?? "")
                        .foregroundColor(Color.onTertiary)
                        .font(.headline)

                    if (alter.alterPronouns?.isEmpty == false) {
                        Text("(\(alter.alterPronouns!))")
                            .foregroundColor(Color.onTertiary)
                            .font(.subheadline)
                    }
                }
                Spacer()
                Button(
                    action: {
                        if (alter.isFronting) {
                            dispatch(FrontActions.RemoveAlterFromFront(alter: alter))
                        } else {
                            dispatch(FrontActions.SetAlterAsFront(alter: alter))
                        }
                    },
                    label: {
                        if (alter.isFronting) {
                            Image(systemName: "arrow.down")
                                .accessibilityLabel("Remove \(alter.alterName ?? "alter") from front")
                                .foregroundColor(Color.onTertiary)
                        } else {
                            Image(systemName: "arrow.up")
                                .accessibilityLabel("Add \(alter.alterName ?? "alter") to front")
                                .foregroundColor(Color.onTertiary)
                        }
                        
                    }
                )
            }
            if (alter.frontingDate != nil && alter.isFronting) {
                Text("Fronting For:")
                    .font(.subheadline)
                    .foregroundColor(Color.onTertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(alter.frontingDate!, style: .relative)
                    .font(.subheadline)
                    .foregroundColor(Color.onTertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else if (alter.frontingDate != nil) {
                Text("Last Fronted:")
                    .font(.subheadline)
                    .foregroundColor(Color.onTertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(alter.frontingDate!, style: .date)
                    .font(.subheadline)
                    .foregroundColor(Color.onTertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onTapGesture {
            dispatch(FrontActions.SelectAlter(alterId: alter.id))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.tertiary)
        .clipShape(RoundedRectangle(cornerRadius: CGFloat(5)))
    }
}


private struct FrontAltersView: View {
    let upFrontAlters: [AlterUIModel]
    let dispatch: Dispatch<FrontActions>
    
    var body: some View {
        VStack {
            HStack {
                Text("Up Front Alters")
                    .font(.title)
                    .foregroundColor(Color.onBackground)
                Spacer()
            }
            
            Divider()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(upFrontAlters) { alter in
                    AlterCard(alter: alter, dispatch: dispatch)
                }
            }
        }
    }
}

struct FrontView_Loading_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            FrontView_Internal(
                state: FrontState.Loading,
                dispatch: { _ in }
            )
                .preferredColorScheme($0)
        }
    }
}

struct FrontView_Loaded_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            FrontView_Internal(
                state: FrontState.Loaded(
                    searchString: "",
                    isCurrentUser: true,
                    selectedAlter: nil,
                    selectedSystem: UserUIModel(
                        userId: "test",
                        systemName: "The council of Cate",
                        systemPronoun: "She/They",
                        systemColor: "#4cdbe6",
                        systemProfileImage: nil
                    ),
                    alters: [
                        AlterUIModel(
                            id: "test",
                            profileId: "test",
                            alterName: "Test Alter",
                            alterPronouns: "He/Him",
                            alterDescription: "Test des",
                            alterRole: "test role",
                            alterColor: "#4cdbe6",
                            alterProfilePhoto: nil,
                            isFronting: true,
                            frontingDate: Date.now
                        ),
                        AlterUIModel(
                            id: "test",
                            profileId: "test",
                            alterName: "Test Alter",
                            alterPronouns: "He/Him",
                            alterDescription: "Test des",
                            alterRole: "test role",
                            alterColor: "#4cdbe6",
                            alterProfilePhoto: nil,
                            isFronting: true,
                            frontingDate: Date.now
                        ),
                        AlterUIModel(
                            id: "test",
                            profileId: "test",
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
                            id: "test",
                            profileId: "test",
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
                .preferredColorScheme($0)
        }
    }
}
