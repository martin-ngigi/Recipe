/*
* Created by Martin Wainaina on 26/07/2026
*
* Feel free to contribute.
*/

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
            let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDc425L193k7Fvr3k2OBsTJTZL4tFjsGKNOq_4ByyjYmHlhRq50cisgW0&s=10")
            NavigationStack {
                ContactDetailView(
                    name: "Steve Jobs",
                    email: "steve@apple.com",
                    imageURL: url!
                )
            }
            .environmentObject(router)
            .environmentObject(tabRouter)
            .modelContainer(for: [RecipeSwiftData.self])
            .modelContainer(for: [IngredientSwiftData.self])
            .frame(minWidth: 375.0, minHeight: 375.0)
            // Keeps the current window's size for use in scrolling header calculations.
            .onGeometryChange(for: CGSize.self) { geometry in
                geometry.size
            } action: {
                ModelData.shared.windowSize = $0
            }
            .onAppear{ onAppear() }
        }
    }
    
    func onAppear(){
        themesViewModel.setAppTheme()
        NotificationManager.shared.requestNotificationPermission()
        MyFirebaseAnalytics.shared.logEvent(title: "app_launch", contentType: "launch")
        MyFirebaseAnalytics.shared.setUserID(DeviceInfo().deviceId)
    }
 
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.primaryTextColor)
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.primaryTextColor)
        ]

        appearance.subtitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.secondaryTextColor)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
