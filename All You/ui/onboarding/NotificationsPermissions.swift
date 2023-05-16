//
//  NotificationsPermissions.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-30.
//

import SwiftUI

struct NotificationsPermissions: View {
    let dispatch: Dispatch<OnboardingActions>
    var body: some View {
        VStack{
            Spacer()
            VStack {
                Spacer()
                VStack {
                    Text("Want Us To Send You Notifications?")
                        .font(.title3)
                        .foregroundColor(Color.onSecondaryContainer)
                    
                    Spacer()
                        .oneVertical()
                    
                    HStack {
                        Button {
                            dispatch(OnboardingActions.NavigateToPreviousPage)
                        } label: {
                            Text("Maybe Later")
                                .font(.body)
                                .foregroundColor(Color.onPrimary)
                                .padding()
                        }
                        .background(Color.primaryColor)
                        .clipShape(Capsule())
                        
                        Spacer()
                        
                        Button {
                            dispatch(OnboardingActions.NavigateToNextPage)
                            let center = UNUserNotificationCenter.current()
                            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                if let error = error {
                                }
                            }

                        } label: {
                            Text("Yes Please")
                                .font(.body)
                                .foregroundColor(Color.onPrimary)
                                .padding()
                        }
                        .background(Color.primaryColor)
                        .clipShape(Capsule())
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.secondaryContainer)
                .clipShape(RoundedRectangle(cornerRadius: CGFloat(20)))
                Spacer()
            }
            .padding()
            .background(Color.background)
        }
    }
}

struct NotificationsPermissions_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            NotificationsPermissions(
                dispatch: {_ in }
            )
                .preferredColorScheme($0)
        }
    }
}
