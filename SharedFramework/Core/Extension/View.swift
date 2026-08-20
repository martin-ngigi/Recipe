/*
* Created by Martin Wainaina on 01/08/2026
*
* Feel free to contribute.
*/

//
//  View.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
import SwiftUI
import os

extension View {

    func fullScreenProgressOverlay(isShowing: Bool, text: String = "Loading...") -> some View {
        self.overlay(
            Group {
                if isShowing {
                    Color(white: 0, opacity: 0.5)
                        .ignoresSafeArea()
                        .contentShape(Rectangle())
                        .overlay(
                            VStack {
                                ProgressView(text)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color(white: 0.2, opacity: 0.7))
                            .cornerRadius(12)
                        )
                }
            },
            alignment: .center
        )
    }

    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }

    func cardBackground(
        cornerRadius: CGFloat = 18,
        background: Color = Color(UIColor.secondarySystemBackground),
        shadowColor: Color = Color.black.opacity(0.06),
        shadowRadius: CGFloat = 20,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 10
    ) -> some View {
        modifier(
            CardBackground(
                cornerRadius: cornerRadius,
                background: background,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                shadowX: shadowX,
                shadowY: shadowY
            )
        )
    }
    
    @ViewBuilder
    func glassCard() -> some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(
                    .regular.tint(Color.theme.whiteAndBlack.opacity(0.5)),
                    in: ConcentricRectangle(
                        corners: .concentric(minimum: 24)
                    )
                )
                .overlay(
                    ConcentricRectangle(
                        corners: .concentric(minimum: 24)
                    )
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.6), .white.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.75
                    )
                )
        }
        else {
            self
                .background(
                    Color.theme.whiteAndBlack.opacity(0.5),
                    in: RoundedRectangle(cornerRadius: 24, style: .continuous)
                )
                .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.theme.blackAndWhite.opacity(0.25), lineWidth: 0.5)
                )
        }
    }
    
    @ViewBuilder
    func glassButtonStyle(isFilled: Bool) -> some View {
        modifier(ConditionalGlassStyle(isFilled: isFilled))
    }

}
