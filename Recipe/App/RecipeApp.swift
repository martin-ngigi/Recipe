//
//  RecipeApp.swift
//  Recipe
//
//  Created by Martin on 12/03/2025.
//

import SwiftUI

@main
struct RecipeApp: App {

    //MARK: HIDE DEFAULT BOTTOM NAV BAR
    init() {
        //Let's remove default bottom navigation by making it clear.
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // This makes background clear
        appearance.backgroundEffect = nil // This removes any blur effect
        appearance.backgroundColor = UIColor.clear // this ensures full transparency
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @StateObject private var themesViewModel = ThemesViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(TabRouter())
                .environmentObject(DashboardViewModel())
                .environmentObject(themesViewModel)
                .preferredColorScheme(themesViewModel.colorScheme)
                
        }
    }
  
}
