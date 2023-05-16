//
//  TextInput.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-04-29.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                Capsule(style: .circular)
                    .stroke(Color.onPrimaryContainer, lineWidth: 2)
            }
    }
}
