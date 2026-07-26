//
//  CustomInbuiltAlert.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import SwiftUI

struct CustomInbuiltAlert {
    let title: Text
    let message: Text
    let primaryButtonText: Text
    let cancelButtonText: Text
    var onPrimaryTap: () -> Void
    var onSecondaryTap: () -> Void

    var signOutAlert: Alert {
        Alert(
            title: title,
            message: message,
            primaryButton: .destructive(
                primaryButtonText,
                action: {
                    onPrimaryTap()
                }
            ),
            secondaryButton: .cancel(
                cancelButtonText,
                action: {
                    onSecondaryTap()
                }
            )
        )
    }
}
