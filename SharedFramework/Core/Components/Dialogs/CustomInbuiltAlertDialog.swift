/*
* Created by Martin Wainaina on 22/08/2026
*
* Feel free to contribute.
*/

//
//  CustomInbuiltAlertDialog.swift
//  Recipe
//
//  Created by RAFIKI on 22/08/2026.
//

import SwiftUI

import SwiftUI

struct CustomInbuiltAlertDialog: ViewModifier {
    @Binding var isPresented: Bool
    
    var title: String
    var text: String
    var confirmButtonText: String = ""
    var dismissButtonText: String = ""
    var imageName: String
    
    var onDismiss: () -> Void
    var onConfirmation: () -> Void
    
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 54
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                
                if !dismissButtonText.isEmpty {
                    Button(dismissButtonText, role: .close) {
                        onDismiss()
                    }
                }
               
                if !confirmButtonText.isEmpty {
                    Button(dismissButtonText, role: .confirm) {
                        onConfirmation()
                    }
                }
                
            } message: {
                Text(text)
            }
    }
}

extension View {
    func customInbuiltAlertDialog(
        title: String,
        message: String,
        confirmButtonText: String = "",
        dismissButtonText: String = "",
        imageName: String = "",
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void,
        onConfirmation: @escaping () -> Void
    ) -> some View {
        modifier(
            CustomInbuiltAlertDialog(
                isPresented: isPresented,
                title: title,
                text: message,
                confirmButtonText: confirmButtonText,
                dismissButtonText: dismissButtonText,
                imageName: imageName,
                onDismiss: onDismiss,
                onConfirmation: onConfirmation
            )
        )
    }
}
