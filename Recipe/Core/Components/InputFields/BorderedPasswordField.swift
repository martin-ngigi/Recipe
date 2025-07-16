//
//  BorderedPasswordField.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

import SwiftUI

struct BorderedPasswordField: View {
    @Binding var password: String
    var placeholder: String = "MyP@ss10"
    var description: String = ""
    var error: String
    @State private var isSecure: Bool = true  // Toggle for visibility
    var onTextChange: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !description.isEmpty {
                Text(description)
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
            }
            
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
            )
            .onChange(of: password){ newValue in
                onTextChange(newValue)
            }
            
            
            if !error.isEmpty {
                Text(error)
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                    .foregroundColor(.red)
            }
        }
    }
}


#Preview {
    BorderedPasswordField(
        password: .constant(""),
        error: "",
        onTextChange: { text in
            
        }
    )
}
