//
//  AlterOnboarding.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import SwiftUI

struct AlterOnboarding: View {
    let state: OnboardingState
    let dispatch: Dispatch<OnboardingActions>
    
    var body: some View {
        VStack {
            Spacer()
            AlterBody(state: state, dispatch: dispatch)
            Spacer()
            AlterBottomButtons(dispatch: dispatch)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

private struct AlterBody: View {
    let state: OnboardingState
    let dispatch: Dispatch<OnboardingActions>
    
    var body: some View {
        let alterNameBinding = Binding(
            get: {state.alterName},
            set: {dispatch(OnboardingActions.UpdateAltername(newName: $0))}
        )
        let alterPronounsBinding = Binding(
            get: {state.alterPronouns},
            set: {dispatch(OnboardingActions.UpdateAlterPronouns(newPronouns: $0))}
        )
        let alterDescriptionBinding = Binding(
            get: {state.alterDescription ?? ""},
            set: {dispatch(OnboardingActions.UpdateAlterDescription(newDescription: $0 ))}
        )
        let alterRoleBinding = Binding(
            get: {state.alterRole ?? ""},
            set: {dispatch(OnboardingActions.UpdateAlterRole(newRole: $0))}
        )
        let colorBinding = Binding(
            get: {Color(hex: state.alterColor)},
            set: {dispatch(OnboardingActions.UpdateAlterColor(newColor: $0.hexString()))}
        )
        
        VStack {
            Text("Let Us Know Who's Up Front")
                .foregroundColor(Color.onBackground)
            
            VStack {
                ProfileViewComponent(
                    onPictueSelected: { data in
                        dispatch(OnboardingActions.UpdateAlterProfilePhoto(newPhoto: data))
                    },
                    photoId: state.alterImage
                )
                
                Spacer()
                    .oneVertical()
                
                TextField("Alter Name", text: alterNameBinding, axis: .horizontal)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .previewLayout(.sizeThatFits)
                
                Spacer()
                    .oneVertical()
                
                TextField("Alter Pronouns", text: alterPronounsBinding, axis: .horizontal)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .previewLayout(.sizeThatFits)
                
                TextField("Alter Description", text: alterDescriptionBinding, axis: .horizontal)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .previewLayout(.sizeThatFits)
                
                TextField("Alter Role", text: alterRoleBinding, axis: .horizontal)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .previewLayout(.sizeThatFits)
                ColorPicker("Alter Color", selection: colorBinding)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.secondaryContainer)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
        }
    }
}

private struct AlterBottomButtons: View {
    let dispatch: Dispatch<OnboardingActions>
    
    var body: some View {
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
                dispatch(OnboardingActions.IsSignlet)
            } label: {
                Text("I don't have alters")
                    .foregroundColor(Color.onPrimaryContainer)
                    .padding()
            }
            .background(Color.primaryColor)
            .clipShape(Capsule())
            
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
}

struct AlterOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AlterOnboarding(
                state: OnboardingState(),
                dispatch: { _ in }
            )
                .preferredColorScheme($0)
        }
    }
}
