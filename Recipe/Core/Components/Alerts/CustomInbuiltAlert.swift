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
    
        /*
        Alert(
            title: Text("Are you sure you want to sign out?"),
            primaryButton: .destructive(Text("Sign Out")) {
                accountStore.signOut()
            },
            secondaryButton: .cancel()
        )
        */
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

//#Preview {
//    CustomInbuiltAlert()
//}
