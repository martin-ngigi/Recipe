//
//  NavBariOS26AndBelow.swift
//  Recipe
//
//  Created by RAFIKI on 20/05/2026.
//

import SwiftUI
import os

struct NavBariOS26AndBelow: View {
    @EnvironmentObject var tabRouter: TabRouter
    @ObservedObject var dashboardViewModel: DashboardViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabRouter.selectedTab) {
                HomeView()
                    .tag(TabItemEntity.home)

                FavouritesListView()
                    .tag(TabItemEntity.favourites)

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
                
                SettingsScreen()
                    .tag(TabItemEntity.settings)

            }

            if dashboardViewModel.isDashboardBottomNavigationVisible && !dashboardViewModel.isKeyboardVisible {
                CustomOverlayNavigation()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            setUpDashboardVisibility()
            setupKeyboardObservers()

        }
        .onDisappear {
            removeKeyboardObservers()
        }
    }
    
    @MainActor
    private func setupKeyboardObservers() {
        dashboardViewModel.keyboardWillShowObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { _ in
            dashboardViewModel.isKeyboardVisible = true
        }

        dashboardViewModel.keyboardWillHideObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { _ in
            dashboardViewModel.isKeyboardVisible = false
        }
    }

    func removeKeyboardObservers() {
        if let observer = dashboardViewModel.keyboardWillShowObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer = dashboardViewModel.keyboardWillHideObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    func setUpDashboardVisibility() {
        dashboardViewModel.keyboardWillHideObserver = NotificationCenter.default.addObserver(
            forName: .dashboardVisibilityChanged,
            object: nil,
            queue: .main
        ) { notification in
            if let isVisible = notification.userInfo?[Constants.isDashboardBottomNavigationVisible] as? Bool {
                dashboardViewModel.isDashboardBottomNavigationVisible = isVisible
                os.Logger().debug(
                    "DEBUG: setUpDashboardVisibility  isDashboardBottomNavigationVisible \(dashboardViewModel.isDashboardBottomNavigationVisible)"
                )
            }
        }
    }
}

#Preview {
    NavBariOS26AndBelow(
        dashboardViewModel: DashboardViewModel()
    )
}
