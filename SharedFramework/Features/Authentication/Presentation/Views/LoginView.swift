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
    @EnvironmentObject var router: Router
    @StateObject var loginViewModel = LoginViewModel()

    // Scales with Dynamic Type so the illustration never crowds the form.
    @ScaledMetric(relativeTo: .largeTitle) private var illustrationSize: CGFloat = 130

    let content = "LoginView"

    var body: some View {
        List {
            headerSection
            credentialsSection
            loginSection
            helpSection
            socialSection
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(.compact)
        .scrollDismissesKeyboard(.interactively)
        .scrollBounceBehavior(.basedOnSize)
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
        .fullScreenProgressOverlay(isShowing: loginViewModel.loginState == .isLoading)
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
            VStack(spacing: 16) {
                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: illustrationSize, height: illustrationSize)
                    .accessibilityHidden(true)  // decorative

                VStack(spacing: 6) {
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
            .padding(.top, 8)
            .padding(.bottom, 4)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
    }

    private var credentialsSection: some View {
        Section {
            BorderedInputField(
                text: $loginViewModel.email,
                placeholder: "Email or username",
                description: "Username/Email",
                error: loginViewModel.loginErrors["email"] ?? "",
                systemImage: "envelope.fill",
                isFocused: focusedInputField == .email,
                keyboardType: .emailAddress,
                textContentType: .username,
                submitLabel: .next,
                onSubmit: { focusedInputField = .password },
                onTextChange: { text in
                    loginViewModel.updateEmail(value: text)
                }
            )
            .focused($focusedInputField, equals: .email)

            BorderedPasswordField(
                password: $loginViewModel.password,
                placeholder: "Password",
                description: "Password",
                error: loginViewModel.loginErrors["password"] ?? "",
                isFocused: focusedInputField == .password,
                isSecure: loginViewModel.isSecure,
                submitLabel: .go,
                onSubmit: { login() },
                onToggleAction: {
                    loginViewModel.isSecure.toggle()
                },
                onTextChange: { text in
                    loginViewModel.updatePassword(value: text)
                }
            )
            .focused($focusedInputField, equals: .password)
        }
    }

    private var loginSection: some View {
        Section {
            Button {
                login()
            } label: {
                Text("Log In")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 28)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: Guidelines.cornerRadius))
            .controlSize(.large)
            .tint(Color.theme.primaryColor)
            .disabled(!loginViewModel.isLoginEnabled)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        }
    }

    private var helpSection: some View {
        Section {
            Button {
                focusedInputField = nil
                loginViewModel.updateIsShowSheet(value: true)
                loginViewModel.updateLoginSheets(value: .RESET_PASSWORD)
                MyFirebaseAnalytics.shared.logEvent(title: "show_reset_password", contentType: content)
            } label: {
                navigationRow(
                    title: "Forgot password?",
                    systemImage: "key.fill",
                    tint: .orange
                )
            }

            Button {
                MyFirebaseAnalytics.shared.logEvent(title: "navigete_to_register", contentType: content)
                router.push(.register(isBackButtonHidden: false))
            } label: {
                navigationRow(
                    title: "Create an account",
                    systemImage: "person.badge.plus.fill",
                    tint: .green
                )
            }
        }
    }

    private var socialSection: some View {
        Section {
            socialRow(title: "Continue with Apple", image: "apple") {
                showComingSoon(provider: "Apple", analyticsKey: "apple")
            }
            socialRow(title: "Continue with Google", image: "google") {
                googleLogin()
            }
            socialRow(title: "Continue with Facebook", image: "facebook") {
                showComingSoon(provider: "Facebook", analyticsKey: "facebook")
            }
        } header: {
            Text("Or continue with")
                .textCase(nil)
        }
    }

    // MARK: - Row builders

    private func navigationRow(title: String, systemImage: String, tint: Color) -> some View {
        HStack(spacing: 12) {
            FormRowIcon(systemName: systemImage, tint: tint)

            Text(title)
                .foregroundStyle(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
                .accessibilityHidden(true)
        }
        .frame(minHeight: 44)
        .contentShape(Rectangle())
    }

    private func socialRow(title: String, image: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .frame(width: 30, height: 30)
                    .accessibilityHidden(true)

                Text(title)
                    .foregroundStyle(.primary)

                Spacer()
            }
            .frame(minHeight: 44)
            .contentShape(Rectangle())
        }
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

    private func login() {
        guard loginViewModel.isLoginEnabled else { return }
        focusedInputField = nil

        Task {
            await loginViewModel.emailAndPasswordLogin(
                onSuccess: {
                    MyFirebaseAnalytics.shared.logEvent(title: "email_login_success", contentType: content)
                    onLoginSuccess()
                },
                onFailure: { error in
                    MyFirebaseAnalytics.shared.logEvent(title: "email_login_failed", contentType: content)
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

#Preview {
    NavigationStack {
        LoginView(
            onLoginSuccess: {},
            onLoginFailure: { _ in }
        )
        .environmentObject(Router())
    }
}
