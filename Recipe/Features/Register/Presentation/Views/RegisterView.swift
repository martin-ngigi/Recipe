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
                    
                    
                    NavigationLink{
                        RegisterView().navigationBarBackButtonHidden()
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
                        }
                    )
                    
                    SocialAuthItemView(
                        image: "google",
                        onTap: {
                        }
                    )
                    
                    SocialAuthItemView(
                        image: "facebook",
                        onTap: {
                        }
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 50)
                
            }
            .padding()
            .reusableToolbar(
                title: "",
                onTapBack: {
                    dismiss()
                }
            )
        }
    }
}

#Preview {
    RegisterView()

}
