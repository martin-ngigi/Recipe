//
//  RootTabView.swift
//  Recipe
//
//  Created by Hummingbird on 04/05/2025.
//

import SwiftUI


import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var tabRouter: TabRouter
    @State var isDashboardBottomNavigationVisible : Bool = true
    @State var isKeyboardVisible : Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch tabRouter.selectedTab {
                case .home:
                    TabNavigationView(router: tabRouter.homeRouter) {
                        HomeView()
                    }
                case .favourites:
                    TabNavigationView(router: tabRouter.favouritesRouter) {
                        FavouritesListView()
                    }
                    .tabItem { Label("Favourites", systemImage: "heart.fill") }
                    .tag(TabItemEntity.favourites)
                    
                case .profile:
                    TabNavigationView(router: tabRouter.profileRouter) {
                        ProfileView()
                    }
                case .settings:
                    TabNavigationView(router: tabRouter.settingsRouter) {
                        SettingsScreen()
                    }
                }
            }
            CustomTabBar(selectedTab: $tabRouter.selectedTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            setUpDashboardVisibility()
            setupKeyboardObservers()
            
        }
    }
    
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = true
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = false
        }
    }
    
    func setUpDashboardVisibility(){
        NotificationCenter.default.addObserver(forName: .dashboardVisibilityChanged, object: nil, queue: .main) { notification in
            if let isVisible = notification.userInfo?["isDashboardBottomNavigationVisible"] as? Bool {
                isDashboardBottomNavigationVisible = isVisible
                print("DEBUG: setUpDashboardVisibility  isDashboardBottomNavigationVisible \(isDashboardBottomNavigationVisible)")
            }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabItemEntity

    var body: some View {
        HStack(spacing: 16) {
            ForEach(TabItemEntity.allCases, id: \.self) { item in
                Button {
                    selectedTab = item
                } label: {
                  
                    ZStack(alignment: .topTrailing) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(item.color)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(item.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(12)
                                    .foregroundColor(.white)
                            )
                        
                        if item == selectedTab {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                                .offset(x: 8, y: -5)
                        }
                    }
                    
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.90, height: 75)
        //.background(Color.gray.opacity(0.5))
        .background(.ultraThinMaterial.opacity(0.9))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.blackAndWhite, lineWidth: 0.5)
        )
        .padding(.horizontal)
        .padding(.bottom, 15)
    }
}

/*
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
            .tag(TabItemEntity.favourites)
            
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
*/

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
