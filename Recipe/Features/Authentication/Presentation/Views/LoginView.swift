//
//  LoginView.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

struct LoginView: View {
    var onLoginSuccess: () -> Void
    var onLoginFailure: (String) -> Void
    @Environment(\.dismiss) var dismiss
    @Environment(\.showError) private var showError
    @EnvironmentObject var router: Router
    @StateObject var loginViewModel = LoginViewModel()

    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 10){
                VStack(spacing: 0){
                    Text("First things first \(LocalState.isLogedIn)")
                        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                    
                    Text("Let's log you in")
                        .font(.custom("\(LocalState.selectedFontPrefix)-Bold", size: 25))
                }
                
                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                VStack(spacing: 10){
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
                    
                    VStack(alignment: .trailing, spacing: 0){
                        BorderedPasswordField(
                            password: $loginViewModel.password,
                            placeholder: "MyP@ss10",
                            description: "Password",
                            error: loginViewModel.loginErrors["password"] ?? "",
                            onTextChange: { text in
                                loginViewModel.updatePassword(value: text)
                            }
                        )
                        
                        Button{
                            loginViewModel.updateIsShowSheet(value: true)
                            loginViewModel.updateLoginSheets(value: .RESET_PASSWORD)
                        } label: {
                            Text("Reset Password?")
                                .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                                .underline()
                                .foregroundColor(Color.theme.primaryColor)
                        }
                    }
                    
                    
                    
                    Button{
                        router.push(.register)
                    } label: {
                        Text("Dont have account? \(Text("Create").foregroundColor(Color.theme.primaryColor))")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
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
                                    onLoginSuccess()
                                },
                                onFailure: { error in
                                    loginViewModel.updateIsShowAlertDialog(value: true)
                                    loginViewModel.updateDialogEntity(
                                        value:  DialogEntity(
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
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                
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
                                        loginViewModel.updateIsShowAlertDialog(value: false)
                                    },
                                    onDismiss: {
                                        loginViewModel.updateIsShowAlertDialog(value: false)
                                    }
                                )
                            )
                        }
                    )
                    
                    SocialAuthItemView(
                        image: "google",
                        onTap: {
                            Task{
                                await loginViewModel.googleAuthentication(
                                    onSuccess: { authDataResult in
                                        Task{
                                            loginViewModel.updateToast(
                                                value: Toast(style: .success, message: "Google authentication successfull!")
                                            )
                                            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0 sec
                                            onLoginSuccess()
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
                            loginViewModel.updateIsShowAlertDialog(value: true)
                            loginViewModel.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming Soon!",
                                    message: "Facebook authentication is coming soon.",
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
                .frame(maxWidth: .infinity)
                .padding(.bottom, 50)
                
            }
            .padding()
        }
        .sheet(isPresented: $loginViewModel.isShowSheet){
            switch loginViewModel.sheetToShow {
            case .RESET_PASSWORD:
                ResetPasswordSheet(
                    email: loginViewModel.resetEmail,
                    resetEmailErrors: loginViewModel.resetEmailErrors,
                    toast: $loginViewModel.toast,
                    isEmailValid: loginViewModel.isResetEmailButtonEnabled,
                    isLoading: loginViewModel.resetPasswordState == .isLoading,
                    onEmailChange: { newEmail in
                        loginViewModel.updateResetEmail(value: newEmail)
                    },
                    onDismiss: {
                        loginViewModel.updateIsShowSheet(value: false)
                    },
                    onSubmit: {
                        Task{
                            await loginViewModel.resetPassword(
                                email: loginViewModel.resetEmail,
                                onSuccess: {
                                    loginViewModel.updateToast(
                                        value: Toast(style: .success, message: "Reset password link sent to your email")
                                    )
                                    loginViewModel.updateIsShowSheet(value: false)
                                },
                                onFailure: { error in
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
        .onAppear{
            print("DEBUG: LocalState.isLogedIn \(LocalState.isLogedIn)")
            if LocalState.isLogedIn{
                onLoginSuccess()
            }
        }
        .fullScreenProgressOverlay(isShowing: loginViewModel.loginState == .isLoading)
        .reusableToolbar(
            title: "",
            onTapBack: {
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
                    if let onDismiss = loginViewModel.dialogEntity.onDismiss {
                        onDismiss()
                    }
                },
                onConfirmation: {
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
        onLoginFailure: {error in}
    )
        .environmentObject(Router())
}
