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

import SwiftUI

/// A text field designed to live inside a `List` / `Form` row.
///
/// The List supplies the grouped background, insets and separators, so this view
/// draws no chrome of its own. Focus is owned by the parent through `isFocused`.
/// Errors appear inline under the field with an icon (never color alone).
struct BorderedInputField: View {
    @Binding var text: String
    var placeholder: String = "Enter text..."
    var description: String = ""
    var error: String
    var systemImage: String? = nil
    var isFocused: Bool = false
    var focusedColor = Color.theme.primaryColor
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var autocapitalization: TextInputAutocapitalization = .never
    var submitLabel: SubmitLabel = .next
    var hasClearButton: Bool = true
    var onSubmit: () -> Void = {}
    var onTextChange: (String) -> Void

    private var hasError: Bool { !error.isEmpty }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                if let systemImage {
                    FormRowIcon(
                        systemName: systemImage,
                        tint: hasError ? Color.theme.errorColor : focusedColor
                    )
                }

                TextField(placeholder, text: $text)
                    .font(.body)
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .textInputAutocapitalization(autocapitalization)
                    .autocorrectionDisabled()
                    .submitLabel(submitLabel)
                    .onSubmit(onSubmit)
                    .onChange(of: text) { _, newValue in
                        onTextChange(newValue)
                    }
                    .accessibilityLabel(description.isEmpty ? placeholder : description)
                    .accessibilityHint(hasError ? error : "")

                if hasClearButton && isFocused && !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.tertiary)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.borderless)  // keeps the tap off the whole row
                    .accessibilityLabel("Clear text")
                    .transition(.opacity)
                }
            }
            .frame(minHeight: 44)

            if hasError {
                Label(error, systemImage: "exclamationmark.circle.fill")
                    .font(.footnote)
                    .foregroundStyle(Color.theme.errorColor)
                    .padding(.bottom, 4)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeOut(duration: 0.2), value: hasError)
        .animation(.easeOut(duration: 0.15), value: isFocused)
    }
}

#Preview {
    List {
        Section("Account") {
            BorderedInputField(
                text: .constant(""),
                placeholder: "Email",
                description: "Email",
                error: "",
                systemImage: "envelope.fill",
                keyboardType: .emailAddress,
                onTextChange: { _ in }
            )

            BorderedInputField(
                text: .constant("not-an-email"),
                placeholder: "Email",
                description: "Email",
                error: "Enter a valid email address",
                systemImage: "envelope.fill",
                onTextChange: { _ in }
            )
        }
    }
}
