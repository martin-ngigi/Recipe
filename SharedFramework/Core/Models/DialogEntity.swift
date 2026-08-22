/*
* Created by Martin Wainaina on 22/08/2026
*
* Feel free to contribute.
*/

//
//  DialogEntity.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import SwiftUI

struct DialogEntity {
    var title: String
    var titleColor: Color
    let message: String
    let messageColor: Color
    let icon: String
    let confirmButtonText: String
    let dismissButtonText: String
    var content: (() -> AnyView)?
    var onConfirm: (() -> Void)?
    var onDismiss: (() -> Void)?

    init(
        title: String = "",
        titleColor: Color = Color.theme.primaryColor,
        message: String = "",
        messageColor: Color = Color.secondary,
        icon: String = "",
        confirmButtonText: String = "",
        dismissButtonText: String = "",
        @ViewBuilder content: @escaping () -> some View,
        onConfirm: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.messageColor = messageColor
        self.titleColor = titleColor
        self.icon = icon
        self.confirmButtonText = confirmButtonText
        self.dismissButtonText = dismissButtonText
        self.content = { AnyView(content()) }
        self.onConfirm = onConfirm
        self.onDismiss = onDismiss
    }

    init(
        title: String = "",
        titleColor: Color = Color.theme.primaryColor,
        message: String = "",
        messageColor: Color = Color.secondary,
        icon: String = "",
        confirmButtonText: String = "",
        dismissButtonText: String = "",
        onConfirm: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.messageColor = messageColor
        self.titleColor = titleColor
        self.icon = icon
        self.confirmButtonText = confirmButtonText
        self.dismissButtonText = dismissButtonText
        self.content = nil
        self.onConfirm = onConfirm
        self.onDismiss = onDismiss
    }
}
