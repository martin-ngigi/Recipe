//
//  ReusableToolbar.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct ReusableToolbar: ViewModifier {
    let title: String
    let backIcon: String
    let dismissIcon: String
    let onTapBack: () -> Void

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: onTapBack) {
                        Image(systemName: backIcon)
                            .foregroundColor(Color.theme.blackAndWhite)
                            .padding(.trailing, 20)
                            .padding(.vertical, 20)
                    }
                }

                //ToolbarItem(placement: .principal) {
                ToolbarItem(placement: .topBarLeading) {
                    Text(title)
                        .font(.custom("ProductSans-Regular", size: 17))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
    }
}

extension View {
    func reusableToolbar(title: String, backIcon: String = "arrow.left", dismissIcon: String = "xmark", onTapBack: @escaping () -> Void) -> some View {
        self.modifier(ReusableToolbar(title: title, backIcon: backIcon, dismissIcon: dismissIcon, onTapBack: onTapBack))
    }
}


#Preview {
    NavigationView {
        VStack{ }
        .reusableToolbar(
            title: "Title",
            onTapBack: {}
        )
    }
}
