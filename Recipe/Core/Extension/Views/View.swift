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
            if let tabBar = findTabBarController()?.tabBar {
                tabBar.isHidden = hidden
                // We want to hide bottom navigation of the dashboard.
                Utils.shared.postDashboardNotifications(isDashoardBottomNavigationVisible: !hidden)
            }
        }
        .onDisappear {
            if let tabBar = findTabBarController()?.tabBar {
                // We want to show bottom navigation of the dashboard.
                tabBar.isHidden = false
            }
        }
        
    }
    
    func findTabBarController() -> UITabBarController? {
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let rootViewController = windowScene.windows.first?.rootViewController else {
           return nil
       }
       return rootViewController as? UITabBarController ?? rootViewController.children.compactMap { $0 as? UITabBarController }.first
   }
    
}
