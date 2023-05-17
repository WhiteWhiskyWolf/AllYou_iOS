//
//  All_YouApp.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

@main
struct All_YouApp: App {
    init() {
        setUpDi()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

extension All_YouApp {
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

