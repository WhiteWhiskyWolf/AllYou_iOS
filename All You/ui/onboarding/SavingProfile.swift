//
//  SavingProfile.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import SwiftUI

struct SavingProfile: View {
    let distpach: Dispatch<OnboardingActions>
    
    var body: some View {
        VStack {
            Text("Saving Profile...")
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear(perform: {
            distpach(OnboardingActions.SaveProfile)
        })
    }
}

struct SavingProfile_Previews: PreviewProvider {
    static var previews: some View {
        SavingProfile(distpach: { _ in })
    }
}
