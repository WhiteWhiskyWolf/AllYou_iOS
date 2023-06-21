//
//  AlterSheetSideEffects.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

struct AlterSheetSideEffects {
    @Service var getAlterUseCase: GetAlterByIDUseCase
    @Service var getCurrentUserUseCase: GetCurrentUserUseCase
    @Service var uploadPhotoUseCase: UploadProfilePhotoUseCase
    @Service var saveAlterUseCase: SaveAlterUseCase
    
    func sideEffects() -> [SideEffect<AlterSheetState, AlterSheetActions>] {
        return [
            onLoadSideEffect,
            onProfilePhoto,
            onSaveAlter,
            onSplitAtler,
            onSelectedHost
        ]
    }
    
    private func onSelectedHost(oldState: AlterSheetState, newState: AlterSheetState, action: AlterSheetActions, dispatch: Dispatch<AlterSheetActions>) async {
        if case .SelectedHost(let alterId) = action {
            if case .Loaded(let alter, _, let isCurrentUser, _) = newState {
                if (alterId.isEmpty) {
                    dispatch(AlterSheetActions.LoaedAlter(alter: alter.copy(hostId: ""), isCurrentUser: isCurrentUser, host: nil))
                } else {
                    let host = await getAlterUseCase.invoke(alterId: alterId)
                    dispatch(AlterSheetActions.LoaedAlter(alter: alter.copy(hostId: host?.id), isCurrentUser: isCurrentUser, host: host))
                }
            }
        }
    }
    
    private func onSplitAtler(oldState: AlterSheetState, newState: AlterSheetState, action: AlterSheetActions, dispatch: Dispatch<AlterSheetActions>) async {
        if case .SplitAlter = action {
            if case .Loaded(let alter, host: let host, let isCurrentUser, _) = newState {
                if isCurrentUser {
                    await saveAlterUseCase.invoke(alter: alter)
                    let currentUser = await getCurrentUserUseCase.invoke()
                    dispatch(
                        .LoaedAlter(
                            alter: AlterUIModel(
                                id: UUID().uuidString,
                                profileId: currentUser?.id ?? UUID().uuidString,
                                hostId: alter.id,
                                alterName: nil,
                                alterPronouns: nil,
                                alterDescription: nil,
                                alterRole: nil,
                                alterColor: "#7f9dbf",
                                alterProfilePhoto: nil,
                                isFronting: false,
                                frontingDate: nil
                            ),
                            isCurrentUser: true,
                            host: host
                        )
                    )
                }
            }
        }
    }
    
    private func onSaveAlter(oldState: AlterSheetState, newState: AlterSheetState, action: AlterSheetActions, dispatch: Dispatch<AlterSheetActions>) async {
        if case .SaveAlter = action {
            if case .Loaded(alter: let alter, _, _, _) = oldState {
                await saveAlterUseCase.invoke(alter: alter)
            }
        }
    }
    
    private func onProfilePhoto(oldState: AlterSheetState, newState: AlterSheetState, action: AlterSheetActions, dispatch: Dispatch<AlterSheetActions>) async {
        if case .UploadPhoto(_, let alterPhoto) = action {
            if case .Loaded(alter: let alter, _, _, _) = newState {
                let id = await uploadPhotoUseCase.invoke(data: alterPhoto, exisitngId: alter.alterProfilePhoto)
                dispatch(AlterSheetActions.UpdatePhotoId(photoId: id))
            }
        }
    }
    
    private func onLoadSideEffect(oldState: AlterSheetState, newState: AlterSheetState, action: AlterSheetActions, dispatch: Dispatch<AlterSheetActions>) async {
        if case .LoadAlter(let alterId) = action {
            if let alter = await getAlterUseCase.invoke(alterId: alterId) {
                var host: AlterUIModel? = nil
                if (alter.hostId != nil) {
                    host = await getAlterUseCase.invoke(alterId: alter.hostId!)
                }
                let currentUser = await getCurrentUserUseCase.invoke()
                dispatch(.LoaedAlter(alter: alter, isCurrentUser: currentUser?.id == alter.profileId, host: host))
            } else {
                let currentUser = await getCurrentUserUseCase.invoke()
                dispatch(
                    .LoaedAlter(
                        alter: AlterUIModel(
                            id: UUID().uuidString,
                            profileId: currentUser?.id ?? UUID().uuidString,
                            hostId: nil,
                            alterName: nil,
                            alterPronouns: nil,
                            alterDescription: nil,
                            alterRole: nil,
                            alterColor: "#7f9dbf",
                            alterProfilePhoto: nil,
                            isFronting: false,
                            frontingDate: nil
                        ),
                        isCurrentUser: true,
                        host: nil
                    )
                )
            }
        }
    }
}
