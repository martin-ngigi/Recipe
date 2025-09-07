//
//  ResetPasswordSheet.swift
//  Recipe
//
//  Created by Hummingbird on 07/09/2025.
//

import SwiftUI

struct ResetPasswordSheet: View {
    @State var email: String
    var resetEmailErrors: [String: String]
    @Binding var toast: Toast?
    var isEmailValid: Bool
    var isLoading: Bool
    var onEmailChange: (String) -> Void
    var onDismiss: () -> Void
    var onSubmit: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Please enter your email address to receive password reset instructions.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            BorderedInputField(
                text: $email,
                placeholder: "myemail@gmail.com",
                description: "Email",
                error: resetEmailErrors["resetEmail"] ?? "",
                keyboardType: .emailAddress,
                onTextChange: { newEmail in
                    onEmailChange(newEmail)
                }
            )

            HStack {
                CustomButton(
                    buttonName: "Cancel",
                    backgroundColor: Color.clear,
                    buttonNameColor: Color.theme.primaryColor,
                    onTap: onDismiss
                )

                CustomButton(
                    buttonName: "Submit",
                    borderColor: Color.clear,
                    isDisabled: !isEmailValid,
                    isLoading: isLoading,
                    onTap: onSubmit
                )
            }

            Spacer()
        }
        .padding()
        .toastView(toast: $toast)
    }
}


#Preview {
    ResetPasswordSheet(
        email: "",
        resetEmailErrors: [:],
        toast: .constant(Toast(style: .success, message: "Sample toast")),
        isEmailValid: false,
        isLoading: false,
        onEmailChange: { newEmail in
            
        },
        onDismiss: {
            
        },
        onSubmit: {
            
        }
    )
}
