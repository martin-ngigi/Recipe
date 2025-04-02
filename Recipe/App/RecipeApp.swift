//
//  RecipeApp.swift
//  Recipe
//
//  Created by Martin on 12/03/2025.
//

import SwiftUI

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(DashboardViewModel())
        }
    }
}
