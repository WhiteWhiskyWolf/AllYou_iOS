//
//  WelcomePage.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-26.
//

import SwiftUI

struct WelcomePage: View {
    let dispatch: Dispatch<OnboardingActions>
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to All You!")
            Spacer()
                .oneVertical()
            Text("Let's take a moment to get to know eachother")
            Spacer()
            HStack {
                Spacer()
                Button {
                    dispatch(OnboardingActions.NavigateToNextPage)
                } label: {
                    Image(systemName: "arrow.right")
                        .accessibilityLabel("Next")
                        .frame(width: 32, height: 32)
                        .padding()
                        .foregroundColor(Color.onPrimary)
                }
                .background(Color.primaryColor)
                .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.background)
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            WelcomePage(dispatch: { _ in })
                .preferredColorScheme($0)
        }
    }
}
