//
//  All_YouApp.swift
//  All You
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct All_YouApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
        ServiceContainer.register(type: AuthenticationRepository.self, AuthenticationRepository())
        ServiceContainer.register(type: UserRepsoitory.self, UserRepsoitory())
        ServiceContainer.register(type: AlterRepository.self, AlterRepository())
        ServiceContainer.register(type: ProfilePhotoRepository.self, ProfilePhotoRepository())
        ServiceContainer.register(type: FrontRepository.self, FrontRepository())
        
        // MARK: Use Cases
        ServiceContainer.register(type: IsUserSignedInUseCase.self, IsUserSignedInUseCase())
        ServiceContainer.register(type: SignInWithGoogleUseCase.self, SignInWithGoogleUseCase())
        ServiceContainer.register(type: HasUseCompletedOnboardingUseCase.self, HasUseCompletedOnboardingUseCase())
        ServiceContainer.register(type: SaveOnboardingUserProfileUseCase.self, SaveOnboardingUserProfileUseCase())
        ServiceContainer.register(type: GetCurrentUserUseCase.self, GetCurrentUserUseCase())
        ServiceContainer.register(type: GetUserAltersUseCase.self, GetUserAltersUseCase())
        ServiceContainer.register(type: SaveAlterUseCase.self, SaveAlterUseCase())
        ServiceContainer.register(type: SearchAltersUseCase.self, SearchAltersUseCase())
        ServiceContainer.register(type: GetAlterByIDUseCase.self, GetAlterByIDUseCase())
        ServiceContainer.register(type: UploadProfilePhotoUseCase.self, UploadProfilePhotoUseCase())
        ServiceContainer.register(type: GetProfilePhotoUseCase.self, GetProfilePhotoUseCase())
        ServiceContainer.register(type: SetAlterToFrontUseCase.self, SetAlterToFrontUseCase())
        ServiceContainer.register(type: RemoveAlterFromFrontUseCase.self, RemoveAlterFromFrontUseCase())
        ServiceContainer.register(type: GetSubAltersUseCase.self, GetSubAltersUseCase())
        ServiceContainer.register(type: GetRootAltersUseCase.self, GetRootAltersUseCase())
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
  }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }


}


