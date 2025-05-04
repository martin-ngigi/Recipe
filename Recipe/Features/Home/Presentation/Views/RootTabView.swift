//
//  RootTabView.swift
//  Recipe
//
//  Created by Hummingbird on 04/05/2025.
//

import SwiftUI

struct RootTabView: View {
    
    @EnvironmentObject var tabRouter: TabRouter
    
    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {
            TabNavigationView(router: tabRouter.homeRouter) {
                HomeView()
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(TabItemEntity.home)
            
            
            
            TabNavigationView(router: tabRouter.favouritesRouter) {
                FavouritesListView()
            }
            .tabItem { Label("Favourites", systemImage: "heart.fill") }
            .tag(TabItemEntity.favoutites)
            
            TabNavigationView(router: tabRouter.settingsRouter) {
                SettingsScreen()
            }
            .tabItem { Label("Settings", systemImage: "gear") }
            .tag(TabItemEntity.settings)
            
            TabNavigationView(router: tabRouter.profileRouter) {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person.circle") }
            .tag(TabItemEntity.profile)
        }
       
    }
}

struct TabNavigationView<Content: View>: View {
    @ObservedObject var router: Router
    let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Route.self) { route in
                    viewForRoute(route, router: router)
                }
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(TabRouter())
}
