/*
* Created by Martin Wainaina on 01/08/2026
*
* Feel free to contribute.
*/

//
//  LoginView.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI
import os

struct LoginView: View {
    var onLoginSuccess: () -> Void
    var onLoginFailure: (String) -> Void
    @FocusState var focusedInputField: LoginInputFields?
    @Environment(\.dismiss) var dismiss
    @Environment(\.showError) private var showError
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @EnvironmentObject var router: Router
    @StateObject var loginViewModel = LoginViewModel()

    // Haptic triggers
    @State private var successCount = 0
    @State private var failureCount = 0

    // Scales with Dynamic Type so the illustration never crowds the form.
    @ScaledMetric(relativeTo: .largeTitle) private var illustrationSize: CGFloat = 110

    let content = "LoginView"

    private var isLoading: Bool { loginViewModel.loginState == .isLoading }
    private var emailError: String { loginViewModel.loginErrors["email"] ?? "" }
    private var passwordError: String { loginViewModel.loginErrors["password"] ?? "" }

    var body: some View {
        List {
            headerSection
            credentialsSection
            loginSection
            socialSection
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(.compact)
        .scrollDismissesKeyboard(.interactively)
        .scrollBounceBehavior(.basedOnSize)
        .allowsHitTesting(!isLoading)
        .frame(maxWidth: 520)  // readable on iPad / landscape
        .frame(maxWidth: .infinity)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .sensoryFeedback(.success, trigger: successCount)
        .sensoryFeedback(.error, trigger: failureCount)
        .overlay {
            CustomPushNotificationView(
                data: loginViewModel.states.popNotificationData,
                isPresented: $loginViewModel.states.isPopNotificationPresented
            )
        }
        .sheet(isPresented: $loginViewModel.isShowSheet) {
            switch loginViewModel.sheetToShow {
            case .RESET_PASSWORD:
                resetPasswordSheet
            }
        }
        .onAppear {
            MyFirebaseAnalytics.shared.logEvent(title: "login_appear", contentType: content)

            os.Logger().debug("DEBUG: LocalState.isLogedIn \(LocalState.isLogedIn)")
            if LocalState.isLogedIn {
                onLoginSuccess()
            }
        }
        .customToolbar(
            title: "",
            onTapBack: {
                MyFirebaseAnalytics.shared.logEvent(title: "login_ontap_back", contentType: content)
                dismiss()
            }
        )
        .customInbuiltAlertDialog(
            title: loginViewModel.dialogEntity.title,
            message: loginViewModel.dialogEntity.message,
            isPresented: $loginViewModel.isShowAlertDialog,
            onDismiss: {
                MyFirebaseAnalytics.shared.logEvent(title: "login_dismiss_dialog", contentType: content)
                loginViewModel.dialogEntity.onDismiss?()
            },
            onConfirmation: {
                MyFirebaseAnalytics.shared.logEvent(title: "login_confirm_dialog", contentType: content)
                loginViewModel.dialogEntity.onConfirm?()
            }
        )
    }

    // MARK: - Sections

    /// Hero: illustration + title, sitting directly on the grouped background.
    private var headerSection: some View {
        Section {
            VStack(spacing: 12) {
                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: illustrationSize, height: illustrationSize)
                    .accessibilityHidden(true)  // decorative

                VStack(spacing: 4) {
                    Text("Welcome back")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)

                    Text("Log in to pick up where you left off.")
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
                text: $loginViewModel.email,
                title: "Username or email",
                placeholder: "Email or username",
                systemImage: "envelope.fill",
                errorMessage: emailError,
                isFocused: focusedInputField == .email,
                keyboardType: .emailAddress,
                textContentType: .username,
                submitLabel: .next,
                onSubmit: { focusedInputField = .password },
                onTextChange: { loginViewModel.updateEmail(value: $0) }
            )
            .focused($focusedInputField, equals: .email)

            FormFieldRow(
                kind: .secure,
                text: $loginViewModel.password,
                title: "Password",
                placeholder: "Password",
                systemImage: "lock.fill",
                errorMessage: passwordError,
                isFocused: focusedInputField == .password,
                isRevealed: !loginViewModel.isSecure,
                textContentType: .password,
                submitLabel: .go,
                onSubmit: { login() },
                onToggleReveal: { toggleRevealPassword() },
                onTextChange: { loginViewModel.updatePassword(value: $0) }
            )
            .focused($focusedInputField, equals: .password)
        } footer: {
            VStack(alignment: .leading, spacing: 4) {
                if !emailError.isEmpty {
                    FormErrorLabel(message: emailError)
                }
                if !passwordError.isEmpty {
                    FormErrorLabel(message: passwordError)
                }

                HStack {
                    Spacer()
                    Button {
                        focusedInputField = nil
                        loginViewModel.updateIsShowSheet(value: true)
                        loginViewModel.updateLoginSheets(value: .RESET_PASSWORD)
                        MyFirebaseAnalytics.shared.logEvent(title: "show_reset_password", contentType: content)
                    } label: {
                        Text("Forgot password?")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(Color.theme.primaryColor)
                            .frame(minHeight: 44)  // HIG minimum tap target
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .animation(reduceMotion ? nil : .easeOut(duration: 0.2), value: emailError + passwordError)
        }
    }

    private var loginSection: some View {
        Section {
            Button {
                login()
            } label: {
                Group {
                    if isLoading {
                        ProgressView().tint(.white)
                    } else {
                        Text("Log In")
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 28)
            }
            .primaryActionButtonStyle()
            .controlSize(.large)
            .tint(Color.theme.primaryColor)
            .disabled(!loginViewModel.isLoginEnabled)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        } footer: {
            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .foregroundStyle(.secondary)

                Button {
                    MyFirebaseAnalytics.shared.logEvent(title: "navigete_to_register", contentType: content)
                    router.push(.register(isBackButtonHidden: false))
                } label: {
                    Text("Create one")
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
                socialButton(title: "Continue with Apple", image: "apple") {
                    showComingSoon(provider: "Apple", analyticsKey: "apple")
                }
                socialButton(title: "Continue with Google", image: "google") {
                    googleLogin()
                }
                socialButton(title: "Continue with Facebook", image: "facebook") {
                    showComingSoon(provider: "Facebook", analyticsKey: "facebook")
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        } header: {
            Text("Or continue with")
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

    private var resetPasswordSheet: some View {
        ResetPasswordSheet(
            email: $loginViewModel.resetEmail,
            resetEmailErrors: loginViewModel.resetEmailErrors,
            popNotificationData: loginViewModel.states.popNotificationData,
            isPopNotificationPresented: $loginViewModel.states.isPopNotificationPresented,
            isEmailValid: loginViewModel.isResetEmailButtonEnabled,
            isLoading: loginViewModel.resetPasswordState == .isLoading,
            onEmailChange: { newEmail in
                loginViewModel.updateResetEmail(value: newEmail)
            },
            onDismiss: {
                MyFirebaseAnalytics.shared.logEvent(title: "dismiss_email_reset_sheet", contentType: content)
                loginViewModel.updateIsShowSheet(value: false)
            },
            onSubmit: {
                MyFirebaseAnalytics.shared.logEvent(title: "submit_email_reset_sheet", contentType: content)
                Task { await submitPasswordReset() }
            }
        )
        .conditionalPresentationDetents(dents: [.medium, .large])
        .presentationDragIndicator(.visible)
    }

    // MARK: - Actions

    /// Swapping SecureField <-> TextField drops focus, so restore it after the swap.
    private func toggleRevealPassword() {
        let wasFocused = focusedInputField == .password
        loginViewModel.isSecure.toggle()
        if wasFocused {
            Task { @MainActor in focusedInputField = .password }
        }
    }

    private func focusFirstInvalidField() {
        if loginViewModel.email.isEmpty || !emailError.isEmpty {
            focusedInputField = .email
        } else {
            focusedInputField = .password
        }
    }

    private func login() {
        guard !isLoading else { return }
        guard loginViewModel.isLoginEnabled else {
            // Reached via the keyboard's Go key with invalid input.
            focusFirstInvalidField()
            failureCount += 1
            return
        }
        focusedInputField = nil

        Task {
            await loginViewModel.emailAndPasswordLogin(
                onSuccess: {
                    MyFirebaseAnalytics.shared.logEvent(title: "email_login_success", contentType: content)
                    successCount += 1
                    onLoginSuccess()
                },
                onFailure: { error in
                    MyFirebaseAnalytics.shared.logEvent(title: "email_login_failed", contentType: content)
                    failureCount += 1
                    loginViewModel.updateIsShowAlertDialog(value: true)
                    loginViewModel.updateDialogEntity(
                        value: DialogEntity(
                            title: "Authentication Failed.",
                            message: error,
                            icon: "",
                            confirmButtonText: "Okay",
                            dismissButtonText: "",
                            onConfirm: {
                                loginViewModel.updateIsShowAlertDialog(value: false)
                                onLoginFailure(error)
                            },
                            onDismiss: {
                                loginViewModel.updateIsShowAlertDialog(value: false)
                            }
                        )
                    )
                }
            )
        }
    }

    private func googleLogin() {
        focusedInputField = nil

        Task {
            await loginViewModel.googleAuthentication(
                onSuccess: { _ in
                    Task {
                        MyFirebaseAnalytics.shared.logEvent(title: "google_auth_success", contentType: content)
                        successCount += 1

                        loginViewModel.updatePopNotificationData(
                            data: PopNotificationData(
                                title: "Login Success",
                                message: "You have been signed in successfully using Google.",
                                type: .success
                            ),
                            isPresented: true
                        )
                        await loginViewModel.sleep(nanoseconds: 1_000_000_000)
                        onLoginSuccess()
                    }
                },
                onFailure: { error in
                    MyFirebaseAnalytics.shared.logError(message: error, screen: content)
                    MyFirebaseAnalytics.shared.logEvent(title: "google_auth_failed", contentType: content)
                    failureCount += 1

                    loginViewModel.updateIsShowAlertDialog(value: true)
                    loginViewModel.updateDialogEntity(
                        value: DialogEntity(
                            title: "Authentication Failed",
                            titleColor: Color.red,
                            message: error,
                            icon: "",
                            confirmButtonText: "",
                            dismissButtonText: "Okay",
                            onConfirm: {
                                MyFirebaseAnalytics.shared.logEvent(title: "confirm_google_dialog", contentType: content)
                                loginViewModel.updateIsShowAlertDialog(value: false)
                            },
                            onDismiss: {
                                MyFirebaseAnalytics.shared.logEvent(title: "dismiss_google_dialog", contentType: content)
                                loginViewModel.updateIsShowAlertDialog(value: false)
                            }
                        )
                    )
                }
            )
        }
    }

    private func showComingSoon(provider: String, analyticsKey: String) {
        focusedInputField = nil
        loginViewModel.updateIsShowAlertDialog(value: true)
        loginViewModel.updateDialogEntity(
            value: DialogEntity(
                title: "Coming Soon!",
                message: "\(provider) authentication is coming soon.",
                icon: "",
                confirmButtonText: "",
                dismissButtonText: "Okay",
                onConfirm: {
                    MyFirebaseAnalytics.shared.logEvent(title: "confirm_\(analyticsKey)_dialog", contentType: content)
                    loginViewModel.updateIsShowAlertDialog(value: false)
                },
                onDismiss: {
                    MyFirebaseAnalytics.shared.logEvent(title: "dismiss_\(analyticsKey)_dialog", contentType: content)
                    loginViewModel.updateIsShowAlertDialog(value: false)
                }
            )
        )
    }

    private func submitPasswordReset() async {
        await loginViewModel.resetPassword(
            email: loginViewModel.resetEmail,
            onSuccess: {
                MyFirebaseAnalytics.shared.logEvent(title: "reset_password_success", contentType: content)

                loginViewModel.updatePopNotificationData(
                    data: PopNotificationData(
                        title: "Reset link sent successfully.",
                        message: "Please check your email.",
                        type: .success
                    ),
                    isPresented: true
                )
                loginViewModel.updateIsShowSheet(value: false)
            },
            onFailure: { error in
                MyFirebaseAnalytics.shared.logError(message: error, screen: content)

                loginViewModel.updatePopNotificationData(
                    data: PopNotificationData(
                        title: "Failed to send link",
                        message: error,
                        type: .error
                    ),
                    isPresented: true
                )
            }
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
        LoginView(
            onLoginSuccess: {},
            onLoginFailure: { _ in }
        )
        .environmentObject(Router())
    }
}
