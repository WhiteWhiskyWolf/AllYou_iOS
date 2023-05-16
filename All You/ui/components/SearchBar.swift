//
//  SearchBar.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

struct SearchBar<Content: View>: View {
    var text: Binding<String>
    var trailingView: () -> Content
    
    init(text: Binding<String>, @ViewBuilder trailingView: @escaping () -> Content ) {
        self.text = text
        self.trailingView = trailingView
    }

    @State private var isEditing = false
        
    var body: some View {
        HStack {
            TextField("Search ...", text: text)
            
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    text.wrappedValue = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 20)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
            if (!isEditing) {
                trailingView()
            }
        }
        .padding(.vertical, 7)
        .padding(.leading, 25)
        .padding(.trailing, 5)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        text.wrappedValue = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }
        )
        .onTapGesture {
            self.isEditing = true
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), trailingView: {Image(systemName: "person")})
        SearchBar(text: .constant(""), trailingView: {Image(systemName: "person")})
    }
}
