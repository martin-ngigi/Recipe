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
    @EnvironmentObject var themesViewModel: ThemesViewModel
    
    var body: some View {
        VStack(spacing: 10){
            VStack(spacing: 0){
                Text("First things first")
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                
                Text("Let's log you in")
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Bold", size: 25))
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
            }
            
            CustomButton(
                buttonName: "Login",
                onTap: {
                    
                }
            )
            .padding(.top, 20)
            
            Text("Or Login with")
                .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
            
            HStack {
                Image("apple_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10) // Add padding for better spacing
                   .background(Color.gray.opacity(0.2)) // Light gray background
                   .clipShape(RoundedRectangle(cornerRadius: 6)) // Ensures the background follows the shape
                   .overlay(
                       RoundedRectangle(cornerRadius: 6)
                           .stroke(Color.gray, lineWidth: 1) // Gray border
                   )
                
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10) // Add padding for better spacing
                       .background(Color.gray.opacity(0.2)) // Light gray background
                       .clipShape(RoundedRectangle(cornerRadius: 6)) // Ensures the background follows the shape
                       .overlay(
                           RoundedRectangle(cornerRadius: 6)
                               .stroke(Color.gray, lineWidth: 1) // Gray border
                       )
                
                Image("facebook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10) // Add padding for better spacing
                       .background(Color.gray.opacity(0.2)) // Light gray background
                       .clipShape(RoundedRectangle(cornerRadius: 6)) // Ensures the background follows the shape
                       .overlay(
                           RoundedRectangle(cornerRadius: 6)
                               .stroke(Color.gray, lineWidth: 1) // Gray border
                       )
                                
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(ThemesViewModel())
}
