//
//  BorderedInputField.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation

import SwiftUI

struct BorderedInputField: View {
    @Binding var text: String
    @State var placeholder: String = "Enter text..."
    @State var description: String = ""
    @Binding var error: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !description.isEmpty {
                Text(description)
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
            }
            
            TextField(placeholder, text: $text)
                .textFieldStyle(TappableTextFieldStyle()) // This will help increase tap area of textfield
                .background(Color.gray.opacity(0.3))
                .cornerRadius(7)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.gray, lineWidth: 0.3)
                ) // Border
            
            if !error.isEmpty {
                Text(error)
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                    .foregroundColor(Color.red)
            }
        }
    }
}

struct TappableTextFieldStyle: TextFieldStyle { // https://stackoverflow.com/questions/56795712/swiftui-textfield-touchable-area
    @FocusState private var textFieldFocused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}

#Preview {
    BorderedInputField(text: .constant(""), error: .constant(""))
        .padding(.horizontal)
}
