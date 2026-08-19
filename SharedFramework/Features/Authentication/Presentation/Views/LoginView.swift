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

    let content = "LoginView"

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                VStack(spacing: 0) {
                    Text("First things first")
                        .font(.appFootnote)

                    Text("Let's log you in")
                        .font(.appLargeTitle)
                }

                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                VStack(spacing: 10) {
                    BorderedInputField(
                        text: $loginViewModel.email,
                        placeholder: "myemail@gmail.com",
                        description: "Username/Email",
                        error: loginViewModel.loginErrors["email"] ?? "",
                        keyboardType: .emailAddress,
                        onTextChange: { text in
                            loginViewModel.updateEmail(value: text)
                        }
                    )
                    .focused($focusedInputField, equals: .email)

                    VStack(alignment: .trailing, spacing: 0) {
                        BorderedPasswordField(
                            password: $loginViewModel.password,
                            placeholder: "MyP@ss10",
                            description: "Password",
                            error: loginViewModel.loginErrors["password"] ?? "",
                            isSecure: loginViewModel.isSecure,
                            onToggleAction: {
                                loginViewModel.isSecure.toggle()
                            },
                            onTextChange: { text in
                                loginViewModel.updatePassword(value: text)
                            }
                        )
                        .focused($focusedInputField, equals: .password)

                        Button {
                            loginViewModel.updateIsShowSheet(value: true)
                            loginViewModel.updateLoginSheets(value: .RESET_PASSWORD)
                            MyFirebaseAnalytics.shared.logEvent(title: "show_reset_password", contentType: content)

                        } label: {
                            Text("Reset Password?")
                                .font(.appFootnote)
                                .underline()
                                .foregroundColor(Color.theme.primaryColor)
                        }
                    }

                    Button {
                        MyFirebaseAnalytics.shared.logEvent(title: "navigete_to_register", contentType: content)
                        router.push(.register(isBackButtonHidden: false))
                    } label: {
                        Text("Dont have account? \(Text("Create").foregroundColor(Color.theme.primaryColor))")
                            .font(.appFootnote)
                            .underline()
                    }
                    .foregroundColor(Color.theme.blackAndWhite)

                }

                CustomButton(
                    buttonName: "Login",
                    borderColor: Color.clear,
                    isDisabled: !loginViewModel.isLoginEnabled,
                    onTap: {
                        Task {
                            await loginViewModel.emailAndPasswordLogin(
                                onSuccess: {
                                    MyFirebaseAnalytics.shared.logEvent(
                                        title: "email_login_success",
                                        contentType: content
                                    )
                                    onLoginSuccess()
                                },
                                onFailure: { error in
                                    MyFirebaseAnalytics.shared.logEvent(
                                        title: "email_login_failed",
                                        contentType: content
                                    )
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
                )
                .padding(.top, 20)

                Text("Or Login with")
                    .font(.appFootnote)

                HStack {
                    SocialAuthItemView(
                        image: "apple_icon",
                        onTap: {
                            loginViewModel.updateIsShowAlertDialog(value: true)
                            loginViewModel.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming Soon!",
                                    message: "Apple authentication is coming soon.",
                                    icon: "",
                                    confirmButtonText: "",
                                    dismissButtonText: "Okay",
                                    onConfirm: {
                                        MyFirebaseAnalytics.shared.logEvent(
                                            title: "confirm_apple_dialog",
                                            contentType: content
                                        )
                                        loginViewModel.updateIsShowAlertDialog(value: false)
                                    },
                                    onDismiss: {
                                        MyFirebaseAnalytics.shared.logEvent(
                                            title: "dismiss_apple_dialog",
                                            contentType: content
                                        )
                                        loginViewModel.updateIsShowAlertDialog(value: false)
                                    }
                                )
                            )
                        }
                    )

                    SocialAuthItemView(
                        image: "google",
                        onTap: {
                            Task {
                                await loginViewModel.googleAuthentication(
                                    onSuccess: { _ in
                                        Task {
                                            MyFirebaseAnalytics.shared.logEvent(
                                                title: "google_auth_success",
                                                contentType: content
                                            )
                                            loginViewModel.updateToast(
                                                value: Toast(
                                                    style: .success,
                                                    message: "Google authentication successfull!"
                                                )
                                            )
                                            await loginViewModel.sleep(nanoseconds: 1_000_000_000)
                                            onLoginSuccess()
                                        }
                                    },
                                    onFailure: { error in
                                        MyFirebaseAnalytics.shared.logError(message: error, screen: content)
                                        MyFirebaseAnalytics.shared.logEvent(
                                            title: "google_auth_failed",
                                            contentType: content
                                        )

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
                                                    MyFirebaseAnalytics.shared.logEvent(
                                                        title: "confirm_google_dialog",
                                                        contentType: content
                                                    )
                                                    loginViewModel.updateIsShowAlertDialog(value: false)
                                                },
                                                onDismiss: {
                                                    MyFirebaseAnalytics.shared.logEvent(
                                                        title: "dismiss_google_dialog",
                                                        contentType: content
                                                    )
                                                    loginViewModel.updateIsShowAlertDialog(value: false)
                                                }
                                            )
                                        )
                                    }
                                )
                            }
                        }
                    )

                    SocialAuthItemView(
                        image: "facebook",
                        onTap: {
                            loginViewModel.updateIsShowAlertDialog(value: true)
                            loginViewModel.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming Soon!",
                                    message: "Facebook authentication is coming soon.",
                                    icon: "",
                                    confirmButtonText: "",
                                    dismissButtonText: "Okay",
                                    onConfirm: {
                                        MyFirebaseAnalytics.shared.logEvent(
                                            title: "confirm_facebook_dialog",
                                            contentType: content
                                        )
                                        loginViewModel.updateIsShowAlertDialog(value: false)
                                    },
                                    onDismiss: {
                                        MyFirebaseAnalytics.shared.logEvent(
                                            title: "dismiss_facebook_dialog",
                                            contentType: content
                                        )
                                        loginViewModel.updateIsShowAlertDialog(value: false)
                                    }
                                )
                            )
                        }
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 50)

            }
            .padding()
        }
        .sheet(isPresented: $loginViewModel.isShowSheet) {
            switch loginViewModel.sheetToShow {
            case .RESET_PASSWORD:
                ResetPasswordSheet(
                    email: $loginViewModel.resetEmail,
                    resetEmailErrors: loginViewModel.resetEmailErrors,
                    toast: $loginViewModel.toast,
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
                        Task {
                            await loginViewModel.resetPassword(
                                email: loginViewModel.resetEmail,
                                onSuccess: {
                                    MyFirebaseAnalytics.shared.logEvent(
                                        title: "reset_password_success",
                                        contentType: content
                                    )
                                    loginViewModel.updateToast(
                                        value: Toast(style: .success, message: "Reset password link sent to your email")
                                    )
                                    loginViewModel.updateIsShowSheet(value: false)
                                },
                                onFailure: { error in
                                    MyFirebaseAnalytics.shared.logError(message: error, screen: content)

                                    loginViewModel.updateToast(
                                        value: Toast(style: .error, message: error)
                                    )
                                }
                            )
                        }
                    }
                )

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
        .toastView(toast: $loginViewModel.toast)
        .overlay {
            CustomAlertDialog(
                isPresented: $loginViewModel.isShowAlertDialog,
                title: loginViewModel.dialogEntity.title,
                text: loginViewModel.dialogEntity.message,
                confirmButtonText: loginViewModel.dialogEntity.confirmButtonText,
                dismissButtonText: loginViewModel.dialogEntity.dismissButtonText,
                imageName: loginViewModel.dialogEntity.icon,
                onDismiss: {
                    MyFirebaseAnalytics.shared.logEvent(title: "login_dismiss_dialog", contentType: content)

                    if let onDismiss = loginViewModel.dialogEntity.onDismiss {
                        onDismiss()
                    }
                },
                onConfirmation: {
                    MyFirebaseAnalytics.shared.logEvent(title: "login_confirm_dialog", contentType: content)

                    if let onConfirm = loginViewModel.dialogEntity.onConfirm {
                        onConfirm()
                    }
                }
            )
        }

    }
}

#Preview {
    LoginView(
        onLoginSuccess: {},
        onLoginFailure: { _ in }
    )
    .environmentObject(Router())
}
