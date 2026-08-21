/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

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
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // isPresented = false // Dismiss when tapping outside
                    }

                VStack(spacing: 8) {

                    Text(title)
                        .font(.appTitle3)
                        .multilineTextAlignment(.center)

                    if !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }

                    Text(text)
                        .font(.appFootnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.blackAndWhite)

                    HStack {

                        if !dismissButtonText.isEmpty {
                            CustomButton(
                                buttonName: dismissButtonText,
                                height: 28,
                                backgroundColor: Color.clear,
                                buttonNameColor: Color.theme.primaryColor
                            ) {
                                onDismiss()
                            }
                        }

                        if !confirmButtonText.isEmpty {
                            CustomButton(
                                buttonName: confirmButtonText,
                                height: 28
                            ) {
                                onConfirmation()
                            }
                        }
                    }
                }
                .padding()
                .glassCard()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.94)
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
        imageName: "",
        onDismiss: {

        },
        onConfirmation: {

        }
    )
}
