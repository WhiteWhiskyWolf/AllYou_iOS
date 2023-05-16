//
//  SystemOnboarding.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-26.
//

import SwiftUI

struct SystemOnboarding: View {
    let state: OnboardingState
    let dispatch: Dispatch<OnboardingActions>
    
    var body: some View {
        let systemNameBinding = Binding(
            get: {
                state.systemName
            },
            set: { newName in
                dispatch(OnboardingActions.UpdateSystemName(newName: newName))
            }
        )
        let pronounBinding = Binding(
            get: {state.systemPronouns},
            set: { newPronouns in
                dispatch(OnboardingActions.UpdateSystemPronounts(newPronouns: newPronouns))
            }
        )
        let colorBinding = Binding(
            get: {Color(hex: state.systemColor)},
            set: { dispatch(OnboardingActions.UpateSystemColor(newColor: $0.hexString())) }
        )
        
        VStack {
            VStack {
                Spacer()
                
                Text("Let's Get To Know You")
                    .font(.title)
                
                Spacer()
                    .oneVertical()
                ProfileViewComponent(
                    profilePictureData: state.systemImage,
                    onPictueSelected: { data in
                        dispatch(OnboardingActions.UpdateSystemProfilePhoto(newPhoto: data))
                    }
                )
                
                Spacer()
                    .oneVertical()
                
                VStack {
                    TextField("System Name", text: systemNameBinding, axis: .horizontal)
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .previewLayout(.sizeThatFits)
                    
                    Spacer()
                        .oneVertical()
                    
                    TextField("Pronouns", text: pronounBinding, axis: .horizontal)
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .previewLayout(.sizeThatFits)
                    
                    Spacer()
                        .oneVertical()
                    
                    ColorPicker("System Color", selection: colorBinding)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.secondaryContainer)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                Spacer()
            }
            Spacer()
            HStack {
                Button {
                    dispatch(OnboardingActions.NavigateToPreviousPage)
                } label: {
                    Image(systemName: "arrow.left")
                        .accessibilityLabel("Previous")
                        .frame(width: 32, height: 32)
                        .padding()
                        .foregroundColor(Color.onPrimary)
                }
                .background(Color.primaryColor)
                .clipShape(Circle())
                
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.background)
    }
}

struct SystemOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SystemOnboarding(
                state: OnboardingState(),
                dispatch: { _ in }
            )
                .preferredColorScheme($0)
        }
    }
}
