//
//  Buttons.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-25.
//

import Foundation
import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.primaryColor)
            .foregroundColor(Color.onPrimary)
            .clipShape(Capsule())
    }
}

struct PrimaryButtonSmall: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.primaryColor)
            .foregroundColor(Color.onPrimary)
            .clipShape(Capsule())
    }
}

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondary)
            .foregroundColor(Color.onSecondary)
            .clipShape(Capsule())
    }
}
