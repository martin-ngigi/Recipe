//
//  BorderedInputField.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation

import SwiftUI

/*
struct BorderedInputField: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @Binding var text: String
    @State var placeholder: String = "Enter text..."
    @State var description: String = ""
    @Binding var error: String
    

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            if !description.isEmpty{
                Text(description)
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
            }
            
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.red.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.3)
                )
            
            if !error.isEmpty{
                Text(error)
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                    .foregroundColor(Color.red)
            }
            
        }
    }
}
*/

import SwiftUI

struct BorderedInputField: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @Binding var text: String
    @State var placeholder: String = "Enter text..."
    @State var description: String = ""
    @Binding var error: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !description.isEmpty {
                Text(description)
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
            }
            
//            ZStack {
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(Color.gray.opacity(0.2)) // Ensures background color is properly clipped
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.gray, lineWidth: 0.3) // Border
//                
//                TextField(placeholder, text: $text)
//                    .padding()
//            }
            TextField(placeholder, text: $text)
                .textFieldStyle(TappableTextFieldStyle()) // This will help increase tap area of textfield
                .background(Color.gray.opacity(0.3))
                .cornerRadius(7)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.gray, lineWidth: 0.3)
                ) // Border
            
            if !error.isEmpty {
                Text(error)
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                    .foregroundColor(Color.red)
            }
        }
    }
}

struct TappableTextFieldStyle: TextFieldStyle { // https://stackoverflow.com/questions/56795712/swiftui-textfield-touchable-area
    @FocusState private var textFieldFocused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}

#Preview {
    BorderedInputField(text: .constant(""), error: .constant(""))
        .padding(.horizontal)
        .environmentObject(ThemesViewModel())
}
