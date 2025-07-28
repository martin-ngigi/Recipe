//
//  View.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
import SwiftUI

extension View {
    func hideBottomNavigationBar(_ hidden: Bool) -> some View {
        self.onAppear {
            print("DEBUG: hideBottomNavigationBar hidden \(hidden)")
            if let tabBar = findTabBarController()?.tabBar {
                tabBar.isHidden = hidden
                tabBar.isUserInteractionEnabled = !hidden
                if hidden {
                    tabBar.frame = .zero
                    if hidden {
                        tabBar.frame.origin.y = UIScreen.main.bounds.height + 100
                    } else {
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
                print("DEBUG: hideBottomNavBar onDisappear  hidden \(false)")
            }
            */
        }
        
    }
    
    func findTabBarController() -> UITabBarController? {
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let rootViewController = windowScene.windows.first?.rootViewController else {
           return nil
       }
       return rootViewController as? UITabBarController ?? rootViewController.children.compactMap { $0 as? UITabBarController }.first
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
    
}
