/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

//
//  ReusableToolbar.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct ReusableToolbar: ViewModifier {
    let title: String
    let dismissIcon: String
    let onTapBack: () -> Void

    func body(content: Content) -> some View {
        content
            .toolbar {
               
                // ToolbarItem(placement: .principal) {
                ToolbarItem(placement: .topBarLeading) {
                    Text(title)
                        .font(.appBody)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Dismiss") {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    }
                }
            }
    }
}

extension View {
    func reusableToolbar(
        title: String,
        dismissIcon: String = "xmark",
        onTapBack: @escaping () -> Void
    ) -> some View {
        self.modifier(
            ReusableToolbar(
                title: title,
                dismissIcon: dismissIcon,
                onTapBack: onTapBack
            )
        )
    }
}

#Preview {
    NavigationView {
        VStack {}
            .reusableToolbar(
                title: "Title",
                onTapBack: {}
            )
    }
}
