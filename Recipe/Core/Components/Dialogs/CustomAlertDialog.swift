//
//  CustomAlertDialog.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import SwiftUI

struct CustomAlertDialog: View {
    @Binding var isPresented: Bool
    var title: String
    var text: String
    var confirmButtonText: String = ""
    var dismissButtonText: String
    var imageName: String
    var onDismiss: () -> Void
    var onConfirmation: () -> Void

    var body: some View {
        ZStack {
            
            if isPresented {
                // Background overlay
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // isPresented = false // Dismiss when tapping outside
                    }
                
                // Alert dialog
                VStack(spacing: 20) {
                    
                    Text(title)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.primaryColor)
                    
                    if !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                    
                    
                    Text(text)
                        .font(.system(size: 17, weight: .light, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.blackAndWhite)
                    
                    HStack {
                        
                        if !dismissButtonText.isEmpty {
                            CustomButton(
                                buttonName: dismissButtonText,
                                backgroundColor: Color.clear,
                                buttonNameColor: Color.theme.primaryColor
                            ) {
                                onDismiss()
                            }
                        }
                        
                        if !confirmButtonText.isEmpty {
                            CustomButton(buttonName: confirmButtonText) {
                                onConfirmation()
                            }
                        }
                    }
                }
                .padding()
                .background(Color.theme.whiteAndBlack)
                .cornerRadius(11)
                .shadow(radius: 18)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.94)
                .overlay(
                       RoundedRectangle(cornerRadius: 11)
                        .stroke(.gray, lineWidth: 1)
                   )
                .padding()
            }
        }
    }
}


#Preview {
    CustomAlertDialog(
        isPresented: .constant(true),
        title: "Oops",
        text: "Error occurred",
        confirmButtonText: "Retry",
        dismissButtonText: "Okay",
        imageName: "error",
        onDismiss: {
            
        },
        onConfirmation: {
            
        }
    )
}
