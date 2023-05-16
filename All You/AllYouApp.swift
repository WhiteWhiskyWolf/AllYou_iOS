//
//  AllYouApp.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-17.
//

import SwiftUI

@main
struct AllYouApp: App {
    init() {
        setUpDi()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

extension AllYouApp {
    private func setUpDi() {
        // MARK: Repositories
        ServiceContainer.register(type: AppwriteClient.self, AppwriteClient())
        ServiceContainer.register(type: AuthenticationRepository.self, AuthenticationRepository())
        ServiceContainer.register(type: UserRepsoitory.self, UserRepsoitory())
        ServiceContainer.register(type: AlterRepository.self, AlterRepository())
        ServiceContainer.register(type: ProfilePhotoRepository.self, ProfilePhotoRepository())
        ServiceContainer.register(type: FrontRepository.self, FrontRepository())
        
        // MARK: Use Cases
        ServiceContainer.register(type: IsUserSignedInUseCase.self, IsUserSignedInUseCase())
        ServiceContainer.register(type: SignInWithAppleUseCase.self, SignInWithAppleUseCase())
        ServiceContainer.register(type: SignInWithGoogleUseCase.self, SignInWithGoogleUseCase())
        ServiceContainer.register(type: HasUseCompletedOnboardingUseCase.self, HasUseCompletedOnboardingUseCase())
        ServiceContainer.register(type: SaveOnboardingUserProfileUseCase.self, SaveOnboardingUserProfileUseCase())
        ServiceContainer.register(type: GetCurrentUserUseCase.self, GetCurrentUserUseCase())
        ServiceContainer.register(type: GetUserAltersUseCase.self, GetUserAltersUseCase())
    }
}
