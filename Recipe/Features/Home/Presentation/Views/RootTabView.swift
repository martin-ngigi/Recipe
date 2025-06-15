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
                    TabNavigationView(router: tabRouter.router) {
                        HomeView()
                    }
                case .favourites:
                    TabNavigationView(router: tabRouter.router) {
                        FavouritesListView()
                    }
                    .tabItem { Label("Favourites", systemImage: "heart.fill") }
                    .tag(TabItemEntity.favourites)
                    
                case .profile:
                    TabNavigationView(router: tabRouter.router) {
                        ProfileView()
                    }
                case .settings:
                    TabNavigationView(router: tabRouter.router) {
                        SettingsScreen()
                    }
                }
            }
            CustomTabBar(selectedTab: $tabRouter.selectedTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
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
