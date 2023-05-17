//
//  AlterReducer.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import Foundation

struct AlterSheetReducer {
    let reducer: Reducer<AlterSheetState, AlterSheetActions> = { state, action in
        switch (action) {
        case .LoadAlter(let alterId):
            return state
        case .LoaedAlter(let alter, let isCurrentUser):
            return AlterSheetState.Loaeded(alter: alter, isCurrentUser: isCurrentUser)
        }
    }
}
