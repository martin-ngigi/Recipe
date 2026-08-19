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
    @EnvironmentObject var router: Router
    @FocusState var focusedInputField: RegisterInputFields?
    @StateObject var registerViewModel = RegisterViewModel()
    @StateObject var loginViewModel = LoginViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                VStack(spacing: 0) {
                    Text("Glad that you are ready to join us!")
                        .font(.appBody)

                    Text("Let's sign you up")
                        .font(.appLargeTitle)
                }

                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                VStack(spacing: 10) {

                    BorderedInputField(
                        text: $registerViewModel.name,
                        placeholder: "John Doe",
                        description: "First and Last Name",
                        error: registerViewModel.registerErrors["name"] ?? "",
                        onTextChange: { text in
                            registerViewModel.updateName(value: text)
                        }
                    )
                    .focused($focusedInputField, equals: .name)

                    BorderedInputField(
                        text: $registerViewModel.email,
                        placeholder: "myemail@gmail.com",
                        description: "Email",
                        error: registerViewModel.registerErrors["email"] ?? "",
                        keyboardType: .emailAddress,
                        onTextChange: { text in
                            registerViewModel.updateEmail(value: text)
                        }
                    )
                    .focused($focusedInputField, equals: .email)

                    BorderedPasswordField(
                        password: $registerViewModel.password,
                        placeholder: "MyP@ss10",
                        description: "Password",
                        error: registerViewModel.registerErrors["password"] ?? "",
                        isSecure: loginViewModel.isSecure,
                        onToggleAction: {
                            registerViewModel.isSecure.toggle()
                        },
                        onTextChange: { text in
                            registerViewModel.updatePassword(value: text)
                        }
                    )
                    .focused($focusedInputField, equals: .password)

                    Button {
                        router.pop()
                    } label: {
                        Text("Already have account? \(Text("Login").foregroundColor(Color.blue))")
                            .font(.appFootnote)
                            .underline()
                    }

                }

                CustomButton(
                    buttonName: "Register",
                    borderColor: Color.clear,
                    isDisabled: !registerViewModel.isRegisterEnabled,
                    onTap: {
                        Task {
                            await registerViewModel.emailAndPasswordRegister(
                                onSuccess: {
                                    registerViewModel.updateIsShowAlertDialog(value: true)
                                    registerViewModel.updateDialogEntity(
                                        value: DialogEntity(
                                            title: "Registration Successful!",
                                            message:
                                                "Welcome to the community! Please check"
                                                + "your email for verification link and proceed to login.",
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
                )
                .padding(.top, 20)

                Text("Or Sign in with")
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))

                HStack {
                    SocialAuthItemView(
                        image: "apple_icon",
                        onTap: {
                            registerViewModel.updateIsShowAlertDialog(value: true)
                            registerViewModel.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming Soon!",
                                    message: "Apple authentication is coming soon.",
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

                    SocialAuthItemView(
                        image: "google",
                        onTap: {
                            Task {
                                await loginViewModel.googleAuthentication(
                                    onSuccess: { _ in
                                        Task {
                                            loginViewModel.updateToast(
                                                value: Toast(
                                                    style: .success,
                                                    message: "Google authentication successfull!"
                                                )
                                            )
                                            await loginViewModel.sleep(nanoseconds: 1_000_000_000)  // 1.0 sec
                                            LocalState.isLogedIn = true
                                            dismiss()
                                        }
                                    },
                                    onFailure: { error in
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
                                                    loginViewModel.updateIsShowAlertDialog(value: false)
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

                    SocialAuthItemView(
                        image: "facebook",
                        onTap: {
                            registerViewModel.updateIsShowAlertDialog(value: true)
                            registerViewModel.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming Soon!",
                                    message: "Facebook authentication is coming soon.",
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
                .frame(maxWidth: .infinity)
                .padding(.bottom, 50)

            }
            .padding()
        }
        .customToolbar(
            title: "",
            onTapBack: {
                dismiss()
            }
        )
        .fullScreenProgressOverlay(
            isShowing: registerViewModel.registeState == .isLoading || loginViewModel.loginState == .isLoading
        )
        .toastView(toast: $loginViewModel.toast)
        .overlay {
            CustomAlertDialog(
                isPresented: $registerViewModel.isShowAlertDialog,
                title: registerViewModel.dialogEntity.title,
                text: registerViewModel.dialogEntity.message,
                confirmButtonText: registerViewModel.dialogEntity.confirmButtonText,
                dismissButtonText: registerViewModel.dialogEntity.dismissButtonText,
                imageName: registerViewModel.dialogEntity.icon,
                onDismiss: {
                    if let onDismiss = registerViewModel.dialogEntity.onDismiss {
                        onDismiss()
                    }
                },
                onConfirmation: {
                    if let onConfirm = registerViewModel.dialogEntity.onConfirm {
                        onConfirm()
                    }
                }
            )
        }
    }
}

#Preview {
    RegisterView(isBackButtonHidden: true)
        .environmentObject(Router())

}
