//
//  RegisterView.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct RegisterView: View {
    @State var name: String = ""
    @State var nameError: String = ""
    @State var username: String = ""
    @State var usernameError: String = ""
    @State var passwordError: String = ""
    @State var password: String = ""
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
                        text: $name,
                        placeholder: "John Doe",
                        description: "First and Last Name",
                        error: $nameError
                    )
                    .onChange(of: name) { newValue in
                        nameError = name.isEmpty ? "Name is empty" : ""
                    }
                    
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
                        router.pop()
                    } label: {
                        Text("Already have account? \(Text("Login").foregroundColor(Color.blue))")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                            .underline()
                    }
                    
                }
                
                CustomButton(
                    buttonName: "Login",
                    onTap: {
                        
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
