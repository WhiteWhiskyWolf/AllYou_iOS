//
//  NewThreadView.swift
//  All You
//
//  Created by Cate Daniel on 2023-06-23.
//

import SwiftUI

struct NewThreadView: View {
    @ObservedObject var store: Store<NewThreadState, NewThreadActions> = Store(
        initialAction: NewThreadActions.getAlters,
        initialState: NewThreadState(
            error: nil,
            searchString: "",
            threadName: "",
            alters: [],
            systems: [],
            systemParticipants: [],
            alterParticipants: [],
            threadPhotoId: nil
        ),
        reducer: NewThreadReducer().reducer,
        sideEffects: NewThreadsSideEffects().sideEffects()
    )
    var body: some View {
        NewThreadView_Internal(
            state: store.state,
            dispatch: store.dispatch
        )
    }
}

struct NewThreadView_Internal: View {
    let state: NewThreadState
    let dispatch: Dispatch<NewThreadActions>
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        let threadNameBinding = Binding(
            get: {state.threadName},
            set: {dispatch(.setThreadName($0))}
        )
        let searchBinding = Binding(
            get: {state.searchString},
            set: {dispatch(.search(searchString:$0))}
        )
        let systemsWithAlters = genearteSystemList(state: state)
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                ProfileViewComponent(
                    onPictueSelected: {dispatch(NewThreadActions.setThreadPhotoId($0!))},
                    photoId: state.threadPhotoId
                )
                Spacer()
            }
            
            Spacer()
                .oneVertical()
            
            TextField("Thread Name", text: threadNameBinding, axis: .horizontal)
                .textFieldStyle(OutlinedTextFieldStyle())
                .previewLayout(.sizeThatFits)
            
            Button(
                "Create Thread",
                action: {
                    dispatch(.saveThread)
                    dismiss()
                })
                .buttonStyle(PrimaryButton())
            
            Divider()
            
            SearchBar(text: searchBinding) {}
            
            ForEach(systemsWithAlters, id: \.id) { systemWithAlters in
                let systemBinding = Binding<Bool>(
                    get: {state.systemParticipants.contains(where: {$0.id == systemWithAlters.system.id})},
                    set: {_ in dispatch(NewThreadActions.toggleSystem(system: systemWithAlters.system))})
                DisclosureGroup(
                    content: {
                        ForEach(systemWithAlters.alters, id: \.id) { alter in
                            let alterBinding = Binding<Bool>(
                                get: {state.alterParticipants.contains(where: {$0.id == alter.id})},
                                set: {_ in dispatch(NewThreadActions.toggleParticipant(alters: alter))}
                            )
                            Toggle(isOn: alterBinding) {
                                HStack {
                                    ProfilePhotoComponent(
                                        imageId: alter.alterProfilePhoto,
                                        name: alter.alterName ?? "Alter",
                                        color: alter.alterColor,
                                        size: CGFloat(20)
                                    )
                                    Spacer()
                                        .oneHorizontal()
                                    Text(alter.alterName ?? "Alter")
                                }
                            }
                        }
                    },
                    label: {
                        Toggle(isOn: systemBinding) {
                            HStack {
                                ProfilePhotoComponent(
                                    imageId: systemWithAlters.system.systemProfileImage,
                                    name: systemWithAlters.system.systemName,
                                    color: systemWithAlters.system.systemColor,
                                    size: CGFloat(20)
                                )
                                Spacer()
                                    .oneHorizontal()
                                Text(systemWithAlters.system.systemName)
                            }
                        }
                    })
            }
            
        }
        .padding()
    }
    
    private func genearteSystemList(state: NewThreadState) -> [SystemWithAlters] {
        var systemList: [SystemWithAlters] = []
        for system in state.systems {
            let alters = state.alters.filter({$0.profileId == system.id})
            let systemWithAlters = SystemWithAlters(id: system.id, system: system, alters: alters)
            systemList.append(systemWithAlters)
        }
        return systemList
    }
}

private struct SystemWithAlters: Identifiable {
    let id: String
    let system: UserUIModel
    let alters: [AlterUIModel]
}

struct NewThreadView_Previews: PreviewProvider {
    static var previews: some View {
        NewThreadView_Internal(
            state: NewThreadState(
                error: nil,
                searchString: "test",
                threadName: "Test Name",
                alters: [
                    AlterUIModel(
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
                    AlterUIModel(
                        id: "test",
                        profileId: "test2",
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
                systems: [
                    UserUIModel(
                        userId: "test",
                        systemName: "Test System",
                        systemPronoun: "he/they",
                        systemColor: "#4cdbe6",
                        systemProfileImage: nil
                    ),
                    UserUIModel(
                        userId: "test2",
                        systemName: "Test System 2",
                        systemPronoun: "he/they",
                        systemColor: "#4cdbe6",
                        systemProfileImage: nil
                    )
                ],
                systemParticipants: [],
                alterParticipants: [],
                threadPhotoId: nil
            ),
            dispatch: {_ in }
        )
    }
}
