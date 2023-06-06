//
//  RootView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-21.
//

import SwiftUI
import Appwrite

struct RootView: View {
    
    @ObservedObject var rootStore: Store<RootState, RootActions>
    @Environment(\.scenePhase)var scenePhase
    
    init() {
        self.rootStore = Store(
            initialAction: .CheckAuth,
            initialState: RootState(),
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
            .registerOAuthHandler()
    }
}

private struct RootViewInternal: View {
    var state: RootState
    var dispatch: Dispatch<RootActions>
    
    var body: some View {
        if (state.isLoggedIn && state.completedOnboarding) {
            HomeView()
        } else if (!state.completedOnboarding && state.isLoggedIn) {
            Onboarding {
                dispatch(RootActions.CheckAuth)
            }
        } else {
            LoginView {
                dispatch(RootActions.CheckAuth)
            }
        }
    }
}
