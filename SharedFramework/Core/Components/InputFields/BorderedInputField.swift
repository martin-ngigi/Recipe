/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

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
    var placeholder: String = "Enter text..."
    var description: String = ""
    var error: String
    @FocusState var isFocused: Bool
    var focusedColor = Color.theme.primaryColor
    var keyboardType: UIKeyboardType = .default
    var hasClearButton: Bool = false
    var onTextChange: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !description.isEmpty {
                Text(description)
                    .font(.appFootnote)
            }

            HStack {
                TextField(placeholder, text: $text)
                    .onChange(of: text) { newValue in
                        onTextChange(newValue)
                    }
                    .textFieldStyle(TappableTextFieldStyle())  // increase tap area

                if !text.isEmpty && hasClearButton {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                }

            }
            .background(Color.gray.opacity(0.15))
            .cornerRadius(12)
            .keyboardType(keyboardType)
            .focused($isFocused)
            .cornerRadius(12)
            .overlay(
                Group {
                    if isFocused {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(error.isEmpty ? focusedColor : Color.theme.redColor, lineWidth: 1)
                    }
                    else {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(error.isEmpty ? Color.gray : Color.theme.redColor, lineWidth: 1)
                    }
                }
            )

            if !error.isEmpty {
                Text(error)
                    .font(.appFootnote)
                    .foregroundColor(Color.red)
            }
        }
    }
}

#Preview {
    BorderedInputField(
        text: .constant(""),
        error: "",
        onTextChange: { _ in

        }
    )
    .padding(.horizontal)
}
