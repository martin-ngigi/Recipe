/*
* Created by Martin Wainaina on 14/08/2026
*
* Feel free to contribute.
*/

//
//  NavBariOS26AndAbove.swift
//  Recipe
//
//  Created by RAFIKI on 20/05/2026.
//

import SwiftUI

@available(iOS 26.0, *)
struct NavBariOS26AndAbove: View {
    @EnvironmentObject var tabRouter: TabRouter
    @State private var search: String = ""

    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {

            TabSection {
                Tab(
                    TabItemEntity.home.title,
                    systemImage: TabItemEntity.home.icon,
                    value: TabItemEntity.home
                ) {
                    HomeView()
                }

                Tab(
                    TabItemEntity.favourites.title,
                    systemImage: TabItemEntity.favourites.icon,
                    value: TabItemEntity.favourites
                ) {
                    FavouritesListView()
                }

                Tab(
                    TabItemEntity.profile.title,
                    systemImage: TabItemEntity.profile.icon,
                    value: TabItemEntity.profile
                ) {
                    Group {
                        if LocalState.isLogedIn {
                            ProfileView(
                                onLogoutSuccess: {
                                    LocalState.isLogedIn = false
                                    tabRouter.selectedTab = .profile
                                },
                                onLogoutFailed: { _ in }
                            )
                        } else {
                            LoginView(
                                onLoginSuccess: {
                                    LocalState.isLogedIn = true
                                    tabRouter.selectedTab = .profile
                                },
                                onLoginFailure: { _ in }
                            )
                        }
                    }
                }

                Tab(
                    TabItemEntity.settings.title,
                    systemImage: TabItemEntity.settings.icon,
                    value: TabItemEntity.settings
                ) {
                    SettingsScreen()
                }
            }

            TabSection {
                Tab(
                    TabItemEntity.search.title,
                    systemImage: "magnifyingglass",
                    value: TabItemEntity.search
                ) {
                    NavigationStack{
                        Text("Search coming soon..")
                            .navigationTitle("Search")
                    }
                }
            }
           
        }
        .tabViewStyle(.sidebarAdaptable)
        .searchable(text: $search)
        .tint(Color.theme.primaryColor)
    }
}

#Preview {
    if #available(iOS 26.0, *) {
        NavBariOS26AndAbove()
    }
    else {
      
    }
}
