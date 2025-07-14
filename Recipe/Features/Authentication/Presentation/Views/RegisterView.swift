//
//  RegisterView.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: Router
    @StateObject var registerViewModel = RegisterViewModel()

    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 10){
                VStack(spacing: 0){
                    Text("Glad that you are ready to join us!")
                        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                    
                    Text("Let's sign you up")
                        .font(.custom("\(LocalState.selectedFontPrefix)-Bold", size: 25))
                }
                
                Image("login_illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                VStack(spacing: 10){
                    
                    BorderedInputField(
                        text: $registerViewModel.name,
                        placeholder: "John Doe",
                        description: "First and Last Name",
                        error: registerViewModel.registerErrors["name"] ?? ""
                    )
                    .onChange(of: registerViewModel.name) { newValue in
                        registerViewModel.updateName(value: newValue)
                    }
                    
                    BorderedInputField(
                        text: $registerViewModel.email,
                        placeholder: "myemail@gmail.com",
                        description: "Email",
                        error: registerViewModel.registerErrors["email"] ?? "",
                        keyboardType: .emailAddress
                    )
                    .onChange(of: registerViewModel.email) { newValue in
                        registerViewModel.updateEmail(value: newValue)
                    }
                    
                    BorderedPasswordField(
                        password: $registerViewModel.password,
                        placeholder: "MyP@ss10",
                        description: "Password",
                        error: registerViewModel.registerErrors["password"] ?? ""
                    )
                    .onChange(of: registerViewModel.password) { newValue in
                        registerViewModel.updatePassword(value: newValue)
                    }
                    
                    
                    Button{
                        router.pop()
                    } label: {
                        Text("Already have account? \(Text("Login").foregroundColor(Color.blue))")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
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
                                            message: "Welcome to the community!",
                                            icon: "",
                                            confirmButtonText: "Proceed",
                                            dismissButtonText: "",
                                            onConfirm: {
                                                registerViewModel.updateIsShowAlertDialog(value: false)
                                                router.push(.dashboard)
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
                            registerViewModel.updateIsShowAlertDialog(value: true)
                            registerViewModel.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming Soon!",
                                    message: "Google authentication is coming soon.",
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
        .reusableToolbar(
            title: "",
            onTapBack: {
                dismiss()
            }
        )
        .fullScreenProgressOverlay(isShowing: registerViewModel.registeState == .isLoading)
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
    RegisterView()
        .environmentObject(Router())

}
