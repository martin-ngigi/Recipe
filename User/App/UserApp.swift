//
//  UserApp.swift
//  User
//
//  Created by RAFIKI on 26/07/2026.
//

import Firebase
import FirebaseCore
import SwiftData
import SwiftUI

@main
struct UserApp: App {
    @AppStorage(Keys.theme.rawValue) var theme = AppTheme.system
    @StateObject var themesViewModel = ThemesViewModel()
    @StateObject var router = Router()
    @StateObject var tabRouter = TabRouter()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .environmentObject(tabRouter)
                .onAppear {
                    themesViewModel.setAppTheme()
                    MyFirebaseAnalytics.shared.logEvent(title: "app_launch", contentType: "launch")
                    MyFirebaseAnalytics.shared.setUserID(DeviceInfo().deviceId)

                }
                .modelContainer(for: [RecipeSwiftData.self])
                .modelContainer(for: [IngredientSwiftData.self])
        }
    }

    // MARK: HIDE DEFAULT BOTTOM NAV BAR
    init() {
        // Let's remove default bottom navigation by making it clear.
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()  // This makes background clear
        appearance.backgroundEffect = nil  // This removes any blur effect
        appearance.backgroundColor = UIColor.clear  // this ensures full transparency
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
