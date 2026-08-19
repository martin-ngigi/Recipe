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
    func hideBottomNavigationBar(_ hidden: Bool) -> some View {
        self.onAppear {
            os.Logger().debug("DEBUG: hideBottomNavigationBar hidden \(hidden)")
            if let tabBar = findTabBarController()?.tabBar {
                tabBar.isHidden = hidden
                tabBar.isUserInteractionEnabled = !hidden
                if hidden {
                    tabBar.frame = .zero
                    if hidden {
                        tabBar.frame.origin.y = UIScreen.main.bounds.height + 100
                    }
                    else {
                        tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBar.frame.height
                    }
                }
                // We want to hide bottom navigation of the dashboard.
                Utils.shared.postDashboardNotifications(isDashboardBottomNavigationVisible: !hidden)
            }
        }
        .onDisappear {
            /*
            if let tabBar = findTabBarController()?.tabBar {
                tabBar.isHidden = false
                tabBar.isUserInteractionEnabled = true
                // Restore tab bar height safely
                if let window = UIApplication.shared.windows.first{
                    let safeAreaBottom = window.safeAreaInsets.bottom
                    let tabBarHeight: CGFloat = 49 + safeAreaBottom
                    tabBar.frame.size.height = tabBarHeight
                    tabBar.isHidden = false
                }
                os.Logger().debug("DEBUG: hideBottomNavBar onDisappear  hidden \(false)")
            }
            */
        }

    }

    func findTabBarController() -> UITabBarController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController
        {
            return rootViewController as? UITabBarController
                ?? rootViewController.children.compactMap { $0 as? UITabBarController }.first
        }
        return nil
    }

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
                        corners: .concentric(minimum: 24),
                        isUniform: true
                    )
                )
                .overlay(
                    ConcentricRectangle(
                        corners: .concentric(minimum: 24),
                        isUniform: true
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
    
    /*
    func swipeBackDisabled(disabled: Bool = true) -> some View {
        modifier(SwipeBackDisabled(disabled: disabled))
    }
    */

}
