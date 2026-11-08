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

/// A password field designed to live inside a `List` / `Form` row, with a show/hide toggle.
///
/// - `.textContentType(.password)` enables AutoFill / iCloud Keychain.
/// - The toggle has a 44×44pt hit area and a VoiceOver label stating the action.
/// - Errors appear inline under the field with an icon (never color alone).
struct BorderedPasswordField: View {
    @Binding var password: String
    var placeholder: String = "Password"
    var description: String = ""
    var error: String
    var systemImage: String? = "lock.fill"
    var isFocused: Bool = false
    var focusedColor = Color.theme.primaryColor
    var isSecure: Bool = true
    var textContentType: UITextContentType = .password
    var submitLabel: SubmitLabel = .go
    var onSubmit: () -> Void = {}
    var onToggleAction: () -> Void
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

                Group {
                    if isSecure {
                        SecureField(placeholder, text: $password)
                    } else {
                        TextField(placeholder, text: $password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                }
                .font(.body)
                .textContentType(textContentType)
                .submitLabel(submitLabel)
                .onSubmit(onSubmit)
                .accessibilityLabel(description.isEmpty ? placeholder : description)
                .accessibilityHint(hasError ? error : "")

                Button {
                    onToggleAction()
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .contentTransition(.symbolEffect(.replace))
                        .foregroundStyle(.secondary)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)  // keeps the tap off the whole row
                .accessibilityLabel(isSecure ? "Show password" : "Hide password")
            }
            .frame(minHeight: 44)
            .onChange(of: password) { _, newValue in
                onTextChange(newValue)
            }

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
            BorderedPasswordField(
                password: .constant("secret"),
                placeholder: "Password",
                description: "Password",
                error: "",
                onToggleAction: {},
                onTextChange: { _ in }
            )

            BorderedPasswordField(
                password: .constant("123"),
                placeholder: "Password",
                description: "Password",
                error: "Password must be at least 8 characters",
                isSecure: false,
                onToggleAction: {},
                onTextChange: { _ in }
            )
        }
    }
}
