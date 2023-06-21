//
//  RootView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-21.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var rootStore: Store<RootState, RootActions>
    @Environment(\.scenePhase)var scenePhase
    
    init() {
        self.rootStore = Store(
            initialAction: .CheckAuth,
            initialState: RootState.loading,
            reducer: RootReducer().reduce,
            sideEffects: RootSideEffects().sideEffects()
        )
    }
    
    var body: some View {
        RootViewInternal(state: rootStore.state, dispatch: rootStore.dispatch)
            .onChange(
                of: scenePhase,
                perform: { newPhase in
                    if (ScenePhase.active == newPhase) {
                        rootStore.dispatch(action: RootActions.CheckAuth)
                    }
                }
            )
    }
}

private struct RootViewInternal: View {
    var state: RootState
    var dispatch: Dispatch<RootActions>
    
    var body: some View {
        switch(state) {
        case .loading:
            LoadingView()
        case .logIn:
            LoginView {
                dispatch(RootActions.CheckAuth)
            }
        case .onboarding:
            Onboarding {
                dispatch(RootActions.CheckAuth)
            }
        case .loggedIn:
            HomeView()
        }
    }
}
