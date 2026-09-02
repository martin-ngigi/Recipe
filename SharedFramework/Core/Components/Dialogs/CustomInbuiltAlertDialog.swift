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
    
    
    init(
        isPresented: Binding<Bool>,
        entity: DialogEntity
    ) {
        self._isPresented = isPresented
        self.title = entity.title
        self.text = entity.message
        self.confirmButtonText = entity.confirmButtonText
        self.dismissButtonText = entity.dismissButtonText
        self.imageName = entity.icon
        self.onDismiss = { entity.onDismiss?() }
        self.onConfirmation = { entity.onConfirm?() }
    }
    
    init(
        isPresented: Binding<Bool>,
        title: String,
        text: String,
        confirmButtonText: String,
        dismissButtonText: String,
        imageName: String,
        onDismiss: @escaping () -> Void,
        onConfirmation: @escaping () -> Void
    ) {
        self._isPresented = isPresented
        self.title = title
        self.text = text
        self.confirmButtonText = confirmButtonText
        self.dismissButtonText = dismissButtonText
        self.imageName = imageName
        self.onDismiss = onDismiss
        self.onConfirmation = onConfirmation
    }
    
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
                    .keyboardShortcut(.defaultAction) // Makes it have primary color
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
    
    func inbuiltAlertDialog(
        isPresented: Binding<Bool>,
        entity: DialogEntity
    ) -> some View {
        modifier(
            CustomInbuiltAlertDialog(
                isPresented: isPresented,
                entity: entity
            )
        )
    }
}

#Preview{
    VStack{
        Text("View here")
        
        Spacer()
    }
    .inbuiltAlertDialog(
        isPresented: .constant(true),
        entity: DialogEntity(
            title: "Title here?",
            message: "This is where your message will be displayed.",
            confirmButtonText: "Proceed",
            dismissButtonText: "Cancel",
            onConfirm: {
            },
            onDismiss: {
            }
        )
    )
}
