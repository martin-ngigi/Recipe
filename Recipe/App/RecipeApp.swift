//
//  RecipeApp.swift
//  Recipe
//
//  Created by Martin on 12/03/2025.
//

import SwiftUI
import SwiftData

import Firebase
import FirebaseCore

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
    
    @AppStorage(Keys.theme.rawValue) var theme: AppTheme = AppTheme.system
    @StateObject var themesViewModel = ThemesViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(Router())
                .environmentObject(TabRouter())
                .onAppear{
                    themesViewModel.setAppTheme()
                }
                .modelContainer(for: [RecipeSwiftData.self])
                .modelContainer(for: [IngredientSwiftData.self])
        }
    }
  
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
