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
                            .cornerRadius(Guidelines.cornerRadius)
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
        cornerRadius: CGFloat = Guidelines.cornerRadius,
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
                    in: RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                )
                .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: Guidelines.cornerRadius)
                        .stroke(Color.theme.blackAndWhite.opacity(0.25), lineWidth: 0.5)
                )
        }
    }
    
    @ViewBuilder
    func glassButtonStyle(isFilled: Bool) -> some View {
        modifier(ConditionalGlassStyle(isFilled: isFilled))
    }
    
    @ViewBuilder
    func glassEffectCustomRectangular(cornerRadius: CGFloat = Guidelines.cornerRadius) -> some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(
                    .regular.interactive(),
                    in: RoundedRectangle(cornerRadius: cornerRadius)
                )
        } else {
            self
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(.gray.opacity(0.2), lineWidth: 0.5)
                }
                .shadow(
                    color: .black.opacity(0.1),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        }
    }
    
    @ViewBuilder
    func glassEffectCustom() -> some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(.regular.interactive())
        }
        else {
            self
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: Guidelines.cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: Guidelines.cornerRadius)
                        .stroke(.gray.opacity(0.2), lineWidth: 0.5)
                }
                .shadow(
                    color: .black.opacity(0.1),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        }
    }
    
    @ViewBuilder
    func conditionalPresentationDetents(
        minOSVersion: Double = 16.0,
        fraction: CGFloat? = nil,
        dents: Set<PresentationDetent>? = nil
    ) -> some View {
        let majorVersion = Int(minOSVersion)
        let minorVersion = Int((minOSVersion * 10).truncatingRemainder(dividingBy: 10))

        if ProcessInfo.processInfo.isOperatingSystemAtLeast(
            OperatingSystemVersion(majorVersion: majorVersion, minorVersion: minorVersion, patchVersion: 0)
        ) {
            if #available(iOS 16.0, *) {
                if let fractionDent = fraction {
                    self.presentationDetents([.fraction(fractionDent)])
                        .presentationDragIndicator(.visible)
                        //.presentationBackground(.thinMaterial)
                        .presentationBackgroundInteraction(.enabled)
                }
                else if let dentss = dents {
                    self.presentationDetents(dentss)
                        .presentationDragIndicator(.visible)
                        //.presentationBackground(.thinMaterial)
                        .presentationBackgroundInteraction(.enabled)
                }
                else {
                    self.presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        //.presentationBackground(.thinMaterial)
                        .presentationBackgroundInteraction(.enabled)
                }
            }
            else {
                self
            }
        }
        else {
            self
        }
    }

    /// A function that returns a view after it applies `FlexibleHeaderContentModifier` to it.
    func flexibleHeaderContent() -> some View {
        modifier(FlexibleHeaderContentModifier())
    }
    
    func flexibleLandingHeaderContent() -> some View {
        modifier(FlexibleLandingHeaderContentModifier())
    }
    
}
