/*
* Created by Martin Wainaina on 01/08/2026
*
* Feel free to contribute.
*/

//
//  RegisterView.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct RegisterView: View {
    let isBackButtonHidden: Bool
    @Environment(\.dismiss) var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @EnvironmentObject var router: Router
    @FocusState var focusedInputField: RegisterInputFields?
    @StateObject var registerViewModel = RegisterViewModel()
    @StateObject var loginViewModel = LoginViewModel()

    // Haptic triggers
    @State private var successCount = 0
    @State private var failureCount = 0

    // Scales with Dynamic Type so the illustration never crowds the form.
    @ScaledMetric(relativeTo: .largeTitle) private var illustrationSize: CGFloat = 100

    private var isRegistering: Bool { registerViewModel.registeState == .isLoading }
    private var isGoogleLoading: Bool { loginViewModel.loginState == .isLoading }
    private var nameError: String { registerViewModel.registerErrors["name"] ?? "" }
    private var emailError: String { registerViewModel.registerErrors["email"] ?? "" }
    private var passwordError: String { registerViewModel.registerErrors["password"] ?? "" }

    var body: some View {
        List {
            headerSection
            credentialsSection
            registerSection
            socialSection
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(.compact)
        .scrollDismissesKeyboard(.interactively)
        .scrollBounceBehavior(.basedOnSize)
        .allowsHitTesting(!isRegistering && !isGoogleLoading)
        .frame(maxWidth: 520)  // readable on iPad / landscape
        .frame(maxWidth: .infinity)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .sensoryFeedback(.success, trigger: successCount)
        .sensoryFeedback(.error, trigger: failureCount)
        .customToolbar(
            title: "",
            onTapBack: {
                dismiss()
            }
        )
        // Only the Google flow uses the full-screen overlay; registering shows a spinner in the button.
        .fullScreenProgressOverlay(isShowing: isGoogleLoading)
        .overlay {
            CustomPushNotificationView(
                data: loginViewModel.states.popNotificationData,
                isPresented: $loginViewModel.states.isPopNotificationPresented
            )
        }
        .overlay {
            CustomAlertDialog(
                isPresented: $registerViewModel.isShowAlertDialog,
                title: registerViewModel.dialogEntity.title,
                text: registerViewModel.dialogEntity.message,
                confirmButtonText: registerViewModel.dialogEntity.confirmButtonText,
                dismissButtonText: registerViewModel.dialogEntity.dismissButtonText,
                imageName: registerViewModel.dialogEntity.icon,
                onDismiss: {
                    registerViewModel.dialogEntity.onDismiss?()
                },
                onConfirmation: {
                    registerViewModel.dialogEntity.onConfirm?()
                }
            )
        }
    }

    // MARK: - Sections

    private var headerSection: some View {
        Section {
            VStack(spacing: 12) {
                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: illustrationSize, height: illustrationSize)
                    .accessibilityHidden(true)  // decorative

                VStack(spacing: 4) {
                    Text("Create your account")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)

                    Text("Glad that you are ready to join us!")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 4)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
    }

    private var credentialsSection: some View {
        Section {
            FormFieldRow(
                kind: .text,
                text: $registerViewModel.name,
                title: "First and last name",
                placeholder: "First and last name",
                systemImage: "person.fill",
                errorMessage: nameError,
                isFocused: focusedInputField == .name,
                textContentType: .name,
                autocapitalization: .words,
                submitLabel: .next,
                onSubmit: { focusedInputField = .email },
                onTextChange: { registerViewModel.updateName(value: $0) }
            )
            .focused($focusedInputField, equals: .name)

            FormFieldRow(
                kind: .text,
                text: $registerViewModel.email,
                title: "Email",
                placeholder: "Email",
                systemImage: "envelope.fill",
                errorMessage: emailError,
                isFocused: focusedInputField == .email,
                keyboardType: .emailAddress,
                textContentType: .emailAddress,
                submitLabel: .next,
                onSubmit: { focusedInputField = .password },
                onTextChange: { registerViewModel.updateEmail(value: $0) }
            )
            .focused($focusedInputField, equals: .email)

            FormFieldRow(
                kind: .secure,
                text: $registerViewModel.password,
                title: "Password",
                placeholder: "Password",
                systemImage: "lock.fill",
                errorMessage: passwordError,
                isFocused: focusedInputField == .password,
                isRevealed: !registerViewModel.isSecure,
                textContentType: .newPassword,  // offers a strong password via AutoFill
                submitLabel: .go,
                onSubmit: { register() },
                onToggleReveal: { toggleRevealPassword() },
                onTextChange: { registerViewModel.updatePassword(value: $0) }
            )
            .focused($focusedInputField, equals: .password)
        } footer: {
            VStack(alignment: .leading, spacing: 4) {
                if !nameError.isEmpty { FormErrorLabel(message: nameError) }
                if !emailError.isEmpty { FormErrorLabel(message: emailError) }
                if !passwordError.isEmpty { FormErrorLabel(message: passwordError) }
            }
            .animation(
                reduceMotion ? nil : .easeOut(duration: 0.2),
                value: nameError + emailError + passwordError
            )
        }
    }

    private var registerSection: some View {
        Section {
            Button {
                register()
            } label: {
                Group {
                    if isRegistering {
                        ProgressView().tint(.white)
                    } else {
                        Text("Register")
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 28)
            }
            .primaryActionButtonStyle()
            .controlSize(.large)
            .tint(Color.theme.primaryColor)
            .disabled(!registerViewModel.isRegisterEnabled)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        } footer: {
            HStack(spacing: 4) {
                Text("Already have an account?")
                    .foregroundStyle(.secondary)

                Button {
                    router.pop()
                } label: {
                    Text("Log in")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.theme.primaryColor)
                }
                .buttonStyle(.plain)
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, minHeight: 44)
        }
    }

    private var socialSection: some View {
        Section {
            HStack(spacing: 12) {
                socialButton(title: "Sign up with Apple", image: "apple") {
                    showComingSoon(provider: "Apple")
                }
                socialButton(title: "Sign up with Google", image: "google") {
                    googleSignUp()
                }
                socialButton(title: "Sign up with Facebook", image: "facebook") {
                    showComingSoon(provider: "Facebook")
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        } header: {
            Text("Or sign up with")
                .textCase(nil)
                .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Builders

    private func socialButton(title: LocalizedStringKey, image: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, minHeight: 28)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: Guidelines.cornerRadius))
        .controlSize(.large)
        .tint(.primary)
        .accessibilityLabel(Text(title))
    }

    // MARK: - Actions

    /// Swapping SecureField <-> TextField drops focus, so restore it after the swap.
    private func toggleRevealPassword() {
        let wasFocused = focusedInputField == .password
        registerViewModel.isSecure.toggle()
        if wasFocused {
            Task { @MainActor in focusedInputField = .password }
        }
    }

    private func focusFirstInvalidField() {
        if registerViewModel.name.isEmpty || !nameError.isEmpty {
            focusedInputField = .name
        } else if registerViewModel.email.isEmpty || !emailError.isEmpty {
            focusedInputField = .email
        } else {
            focusedInputField = .password
        }
    }

    private func register() {
        guard !isRegistering else { return }
        guard registerViewModel.isRegisterEnabled else {
            // Reached via the keyboard's Go key with invalid input.
            focusFirstInvalidField()
            failureCount += 1
            return
        }
        focusedInputField = nil

        Task {
            await registerViewModel.emailAndPasswordRegister(
                onSuccess: {
                    successCount += 1
                    registerViewModel.updateIsShowAlertDialog(value: true)
                    registerViewModel.updateDialogEntity(
                        value: DialogEntity(
                            title: "Registration Successful!",
                            message:
                                "Welcome to the community! Please check "
                                + "your email for the verification link and proceed to login.",
                            icon: "",
                            confirmButtonText: "Proceed",
                            dismissButtonText: "",
                            onConfirm: {
                                registerViewModel.updateIsShowAlertDialog(value: false)
                                dismiss()
                            },
                            onDismiss: {
                                registerViewModel.updateIsShowAlertDialog(value: false)
                            }
                        )
                    )
                },
                onFailure: { error in
                    failureCount += 1
                    registerViewModel.updateIsShowAlertDialog(value: true)
                    registerViewModel.updateDialogEntity(
                        value: DialogEntity(
                            title: "Registration Failed.",
                            message: error,
                            icon: "",
                            confirmButtonText: "",
                            dismissButtonText: "Okay",
                            onConfirm: {
                                registerViewModel.updateIsShowAlertDialog(value: false)
                            },
                            onDismiss: {
                                registerViewModel.updateIsShowAlertDialog(value: false)
                            }
                        )
                    )
                }
            )
        }
    }

    private func googleSignUp() {
        focusedInputField = nil

        Task {
            await loginViewModel.googleAuthentication(
                onSuccess: { _ in
                    Task {
                        successCount += 1
                        loginViewModel.updatePopNotificationData(
                            data: PopNotificationData(
                                title: "Registration Success",
                                message: "You have been authenticated successfully using Google.",
                                type: .success
                            ),
                            isPresented: true
                        )
                        await loginViewModel.sleep(nanoseconds: 1_000_000_000)  // 1.0 sec
                        LocalState.isLogedIn = true
                        dismiss()
                    }
                },
                onFailure: { error in
                    failureCount += 1
                    // Shown through the register dialog: this screen only presents that one,
                    // so a dialog set on loginViewModel would never appear.
                    registerViewModel.updateIsShowAlertDialog(value: true)
                    registerViewModel.updateDialogEntity(
                        value: DialogEntity(
                            title: "Authentication Failed",
                            titleColor: Color.red,
                            message: error,
                            icon: "",
                            confirmButtonText: "",
                            dismissButtonText: "Okay",
                            onConfirm: {
                                registerViewModel.updateIsShowAlertDialog(value: false)
                            },
                            onDismiss: {
                                registerViewModel.updateIsShowAlertDialog(value: false)
                            }
                        )
                    )
                }
            )
        }
    }

    private func showComingSoon(provider: String) {
        focusedInputField = nil
        registerViewModel.updateIsShowAlertDialog(value: true)
        registerViewModel.updateDialogEntity(
            value: DialogEntity(
                title: "Coming Soon!",
                message: "\(provider) authentication is coming soon.",
                icon: "",
                confirmButtonText: "",
                dismissButtonText: "Okay",
                onConfirm: {
                    registerViewModel.updateIsShowAlertDialog(value: false)
                },
                onDismiss: {
                    registerViewModel.updateIsShowAlertDialog(value: false)
                }
            )
        )
    }
}

// MARK: - Styling helpers

private extension View {
    /// Liquid Glass prominent button on iOS 26+, bordered-prominent before that.
    @ViewBuilder
    func primaryActionButtonStyle() -> some View {
        if #available(iOS 26, *) {
            self.buttonStyle(.glassProminent)
        } else {
            self
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: Guidelines.cornerRadius))
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView(isBackButtonHidden: true)
            .environmentObject(Router())
    }
}
