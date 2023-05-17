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
    
    func sideEffects() -> [SideEffect<AlterSheetState, AlterSheetActions>] {
        return [
            onLoadSideEffect
        ]
    }
    
    private func onLoadSideEffect(oldState: AlterSheetState, newState: AlterSheetState, action: AlterSheetActions, dispatch: Dispatch<AlterSheetActions>) async {
        if case .LoadAlter(let alterId) = action {
            if let alter = await getAlterUseCase.invoke(alterId: alterId) {
                let currentUser = await getCurrentUserUseCase.invoke()
                dispatch(.LoaedAlter(alter: alter, isCurrentUser: currentUser?.id == alter.profileId))
            } else {
                let currentUser = await getCurrentUserUseCase.invoke()
                dispatch(
                    .LoaedAlter(
                        alter: AlterUIModel(
                            id: UUID().uuidString,
                            profileId: currentUser?.id ?? UUID().uuidString,
                            alterName: nil,
                            alterPronouns: nil,
                            alterDescription: nil,
                            alterRole: nil,
                            alterColor: "#7f9dbf",
                            alterProfilePhoto: nil,
                            isFronting: false,
                            frontingDate: nil
                        ),
                        isCurrentUser: true
                    )
                )
            }
        }
    }
}
