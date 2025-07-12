//
//  LoginView.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var usernameError: String = ""
    @State var passwordError: String = ""
    @State var password: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.showError) private var showError
    @EnvironmentObject var router: Router
    @StateObject var loginViewModel = LoginViewModel()

    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 10){
                VStack(spacing: 0){
                    Text("First things first")
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
                        text: $username,
                        placeholder: "myemail@gmail.com",
                        description: "Username/Email",
                        error: $usernameError
                    )
                    .onChange(of: username) { newValue in
                        usernameError = username.isEmpty ? "Username is empty" : ""
                    }
                    
                    BorderedPasswordField(
                        password: $password,
                        placeholder: "MyP@ss10",
                        description: "Password",
                        error: $usernameError
                    )
                    .onChange(of: password) { newValue in
                        passwordError = password.isEmpty ? "Username is empty" : ""
                    }
                    
                    
                    Button{
                        router.push(.register)
                    } label: {
                        Text("Already have account? \(Text("Create").foregroundColor(Color.blue))")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                            .underline()
                    }
                    
                }
                
                CustomButton(
                    buttonName: "Login",
                    onTap: {
                        showError(SampleError.operationFailed, "Operation has failed. Please try again later.")
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
                            loginViewModel.updateIsShowAlertDialog(value: true)
                            loginViewModel.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming Soon!",
                                    message: "Google authentication is coming soon.",
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
        .fullScreenProgressOverlay(isShowing: loginViewModel.loginState == .isLoading)
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
        .reusableToolbar(
            title: "",
            onTapBack: {
                dismiss()
            }
        )
    }
}

#Preview {
    LoginView()
        .environmentObject(Router())
}
