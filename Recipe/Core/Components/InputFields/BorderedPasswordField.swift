//
//  BorderedPasswordField.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

import SwiftUI

struct BorderedPasswordField: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @Binding var password: String
    @State var placeholder: String = "MyP@ss10"
    @State var description: String = ""
    @Binding var error: String
    @State private var isSecure: Bool = true  // Toggle for visibility

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !description.isEmpty {
                Text(description)
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
            }
            
            /*
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2)) // Background color
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 0.3) // Border
                
                HStack {
                    if isSecure {
                        SecureField(placeholder, text: $password)
                    } else {
                        TextField(placeholder, text: $password)
                    }
                    
                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            .frame(height: 44)
            */
            
            HStack {
                if isSecure {
                    SecureField(placeholder, text: $password)
                    
                } else {
                    TextField(placeholder, text: $password)
                }
                
                Button(action: { isSecure.toggle() }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
            .textFieldStyle(TappableTextFieldStyle()) // This will help increase tap area of textfield
            .background(Color.gray.opacity(0.3))
            .cornerRadius(7)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.gray, lineWidth: 0.3)
            )// Border
            
            
            if !error.isEmpty {
                Text(error)
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                    .foregroundColor(.red)
            }
        }
    }
}


#Preview {
    BorderedPasswordField(password: .constant(""), error: .constant(""))
}
