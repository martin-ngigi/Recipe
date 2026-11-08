/*
* Created by Martin Wainaina on 08/11/2026
*
* Feel free to contribute.
*/

//
//  FormFieldRow.swift
//  Recipe
//
//  Replaces BorderedInputField and BorderedPasswordField with a single
//  List/Form row that supports plain text and secure (password) input.
//

import SwiftUI

/// A text or secure field designed to live inside a `List` / `Form` row.
///
/// - The List supplies background, insets and separators, so the row draws no chrome.
/// - Validation messages are NOT drawn here. Show them in the Section footer
///   (see `FormErrorLabel`) like Apple's own forms. The row only reflects the
///   error state (icon tile turns red) and exposes the message to VoiceOver.
/// - Focus is owned by the parent: apply `.focused(...)` to this row and pass `isFocused`.
struct FormFieldRow: View {
    enum Kind { case text, secure }

    let kind: Kind
    @Binding var text: String
    var title: LocalizedStringKey                 // spoken by VoiceOver
    var placeholder: LocalizedStringKey
    var systemImage: String? = nil
    var errorMessage: String = ""
    var isFocused: Bool = false
    var isRevealed: Bool = false                  // secure kind only
    var tint: Color = Color.theme.primaryColor
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var autocapitalization: TextInputAutocapitalization = .never
    var submitLabel: SubmitLabel = .next
    var hasClearButton: Bool = true               // text kind only
    var onSubmit: () -> Void = {}
    var onToggleReveal: () -> Void = {}
    var onTextChange: (String) -> Void = { _ in }

    private var hasError: Bool { !errorMessage.isEmpty }

    var body: some View {
        HStack(spacing: 12) {
            if let systemImage {
                FormRowIcon(systemName: systemImage, tint: hasError ? Color.theme.errorColor : tint)
            }

            field
                .font(.body)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .submitLabel(submitLabel)
                .onSubmit(onSubmit)
                .accessibilityLabel(Text(title))
                .accessibilityHint(errorMessage)

            trailingControl
        }
        .frame(minHeight: 44)
        .onChange(of: text) { _, newValue in
            onTextChange(newValue)
        }
    }

    // MARK: - Pieces

    @ViewBuilder
    private var field: some View {
        switch kind {
        case .text:
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled()
        case .secure:
            if isRevealed {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } else {
                SecureField(placeholder, text: $text)
            }
        }
    }

    @ViewBuilder
    private var trailingControl: some View {
        switch kind {
        case .text:
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
            }
        case .secure:
            Button(action: onToggleReveal) {
                Image(systemName: isRevealed ? "eye" : "eye.slash")
                    .contentTransition(.symbolEffect(.replace))
                    .foregroundStyle(.secondary)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.borderless)  // keeps the tap off the whole row
            .accessibilityLabel(isRevealed ? "Hide password" : "Show password")
        }
    }
}

/// Validation message for a Section footer. Icon + text, never color alone.
struct FormErrorLabel: View {
    let message: String

    var body: some View {
        Label(message, systemImage: "exclamationmark.circle.fill")
            .font(.footnote)
            .foregroundStyle(Color.theme.errorColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    List {
        Section {
            FormFieldRow(
                kind: .text,
                text: .constant("martin@"),
                title: "Email",
                placeholder: "Email or username",
                systemImage: "envelope.fill",
                errorMessage: "Enter a valid email address",
                keyboardType: .emailAddress
            )
            FormFieldRow(
                kind: .secure,
                text: .constant("secret"),
                title: "Password",
                placeholder: "Password",
                systemImage: "lock.fill",
                textContentType: .password
            )
        } footer: {
            FormErrorLabel(message: "Enter a valid email address")
        }
    }
}
