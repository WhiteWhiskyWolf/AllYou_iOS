//
//  Store.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-17.
//

typealias Reducer<State, Action> = (State, Action) -> State
typealias Dispatch<Action> = (Action) -> Void
typealias SideEffect<State, Action> = (State, State, Action, @escaping Dispatch<Action>) async -> Void

import Foundation

class Store<State, Action>: ObservableObject {
    
    @Published var state: State
    private let reducer: Reducer<State, Action>
    private let sideEffects: [SideEffect<State, Action>]
    
    init(
        initialAction: Action?,
        initialState: State,
        reducer: @escaping Reducer<State, Action>,
        sideEffects: [SideEffect<State, Action>]
    ) {
        self.reducer = reducer
        self.sideEffects = sideEffects
        self.state = initialState
        
        if (initialAction != nil) {
            dispatch(action: initialAction!)
        }
    }
    
    func dispatch(action: Action) {
        let existingState = self.state
        let newState = reducer(state, action)
        DispatchQueue.main.async {
            self.state = newState
        }
        self.sideEffects.forEach { sideEffect in
            Task {
                await sideEffect(existingState, newState, action, self.dispatch)
            }
        }
    }
}
