//
//  Onboarding.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-26.
//

import SwiftUI

struct Onboarding: View {
    let onSaveProfile: () -> Void
    @ObservedObject var store: Store<OnboardingState, OnboardingActions>
    
    init(onSaveProfile: @escaping () -> Void) {
        self.onSaveProfile = onSaveProfile
        self.store = Store(
            initialAction: nil,
            initialState: OnboardingState(),
            reducer: OnboardingReducer().reducer,
            sideEffects: OnboardingSideEffects(onSaveProfile: onSaveProfile).sideEffects()
        )
    }
    
    var body: some View {
        let selectionBinding = Binding(get: {store.state.page}, set: { _ in })
        TabView(selection: selectionBinding) {
            WelcomePage(dispatch: store.dispatch)
                .tag(0)
            SystemOnboarding(state: store.state, dispatch: store.dispatch)
                .tag(1)
            AlterOnboarding(state: store.state, dispatch: store.dispatch)
                .tag(2)
            NotificationsPermissions(dispatch: store.dispatch)
                .tag(3)
            SavingProfile(distpach: store.dispatch)
                .tag(4)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 0.3), value: selectionBinding.wrappedValue)
        .transition(.slide)
    }
}
