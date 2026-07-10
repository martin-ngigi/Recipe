//
//  ToastModifier.swift
//  Recipe
//
//  Created by Hummingbird on 28/07/2025.
//

import Foundation
import SwiftUI

struct ToastModifier: ViewModifier {

    @Binding var toast: Toast?
    @ObservedObject var viewModel = ToastViewModel()

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: 32)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { _ in
                if let toast = toast {
                    viewModel.showToast(toast)
                }
            }
    }

    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                ToastView(
                    style: toast.style,
                    message: toast.message,
                    width: toast.width
                ) {
                    viewModel.dismissToast()
                }
                Spacer()
            }
        }
    }
}
