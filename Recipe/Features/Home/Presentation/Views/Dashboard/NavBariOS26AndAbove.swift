//
//  NavBariOS26AndAbove.swift
//  Recipe
//
//  Created by RAFIKI on 20/05/2026.
//

import SwiftUI

struct NavBariOS26AndAbove: View {
    @EnvironmentObject var tabRouter: TabRouter

    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {
            
            HomeView()
                .tag(TabItemEntity.home)
                .tabItem {
                    Label(TabItemEntity.home.title, systemImage: TabItemEntity.home.icon)
                }

            FavouritesListView()
                .tag(TabItemEntity.favourites)
                .tabItem {
                    Label(TabItemEntity.favourites.title, systemImage: TabItemEntity.favourites.icon)
                }

           
            Group {
                if LocalState.isLogedIn {
                    ProfileView(
                        onLogoutSuccess: {
                            LocalState.isLogedIn = false
                            tabRouter.selectedTab = .profile
                        },
                        onLogoutFailed: { _ in

                        }
                    )
                }
                else {
                    LoginView(
                        onLoginSuccess: {
                            LocalState.isLogedIn = true
                            tabRouter.selectedTab = .profile
                        },
                        onLoginFailure: { _ in

                        }
                    )
                }
            }
            .tag(TabItemEntity.profile)
            .tabItem {
                Label(TabItemEntity.profile.title, systemImage: TabItemEntity.profile.icon)
            }
            
            SettingsScreen()
                .tag(TabItemEntity.settings)
                .tabItem {
                    Label(TabItemEntity.settings.title, systemImage: TabItemEntity.settings.icon)
                }

        }
        .tint(Color.theme.primaryColor)
    }
}

#Preview {
    NavBariOS26AndAbove()
}
