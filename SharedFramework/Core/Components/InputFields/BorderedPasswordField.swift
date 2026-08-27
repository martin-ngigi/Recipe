/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

//
//  BorderedPasswordField.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

struct BorderedPasswordField: View {
    @Binding var password: String
    var placeholder: String = "MyP@ss10"
    var description: String = ""
    var error: String
    @FocusState var isFocused: Bool
    var focusedColor = Color.theme.primaryColor
    var isSecure: Bool = true
    var onToggleAction: () -> Void
    var onTextChange: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !description.isEmpty {
                Text(description)
                    .font(.appBody)
            }

            HStack {

                if isSecure {
                    SecureField(placeholder, text: $password)
                        .focused($isFocused)
                }
                else {
                    TextField(placeholder, text: $password)
                        .focused($isFocused)
                }

                Button {
                    onToggleAction()
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .contentTransition(.symbolEffect)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
            .textFieldStyle(TappableTextFieldStyle())  // Increase tap area
            .background(Color.gray.opacity(0.15))
            .cornerRadius(24)
            .focused($isFocused)
            .cornerRadius(24)
            .overlay(
                Group {
                    if isFocused {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(error.isEmpty ? focusedColor : Color.theme.redColor, lineWidth: 1)
                    }
                    else {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(error.isEmpty ? Color.gray : Color.theme.redColor, lineWidth: 1)
                    }
                }
            )
            .onChange(of: password) { newValue in
                onTextChange(newValue)
            }

            if !error.isEmpty {
                Text(error)
                    .font(.appFootnote)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    BorderedPasswordField(
        password: .constant(""),
        error: "",
        onToggleAction: {

        },
        onTextChange: { _ in

        }

    )
}
