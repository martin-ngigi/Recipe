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
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
            }

            HStack {
                TextField(placeholder, text: $text)
                    .onChange(of: text) { newValue in
                        onTextChange(newValue)
                    }
                    .textFieldStyle(TappableTextFieldStyle())  // This will help increase tap area of textfield

                if !text.isEmpty && hasClearButton {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .padding(.trailing)
                            .foregroundColor(.red)
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
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
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
