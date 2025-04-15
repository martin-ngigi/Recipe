//
//  RecipeApp.swift
//  Recipe
//
//  Created by Martin on 12/03/2025.
//

import SwiftUI

@main
struct RecipeApp: App {
    @Environment(\.showError) private var showError
    @State private var errorWrapper : ErrorWrapper? = nil

    init() {
        //Let's remove default bottom navigation by making it clear.
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // This makes background clear
        appearance.backgroundEffect = nil // This removes any blur effect
        appearance.backgroundColor = UIColor.clear // this ensures full transparency
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(DashboardViewModel())
                .environmentObject(ThemesViewModel())
                .environment(\.showError, ShowErrorAction(action: showError))
                .sheet(item: $errorWrapper) { errorWrapper in
                    Text(errorWrapper.guidance)
                }
        }
    }
    
    private func showError(error: Error, guidance: String) {
        errorWrapper = ErrorWrapper(error: error, guidance: guidance)
    }
}
