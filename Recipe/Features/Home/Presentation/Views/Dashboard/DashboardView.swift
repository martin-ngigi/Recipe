//
//  DashboardView.swift
//  Recipe
//
//  Created by Martin on 24/03/2025.
//

import SwiftUI
import os

struct DashboardView: View {
    @StateObject var dashboardViewModel = DashboardViewModel()
    @EnvironmentObject var tabRouter: TabRouter

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabRouter.selectedTab) {
                HomeView()
                    .tag(TabItemEntity.home)

                FavouritesListView()
                    .tag(TabItemEntity.favourites)

                SettingsScreen()
                    .tag(TabItemEntity.settings)

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
            }

            if dashboardViewModel.isDashboardBottomNavigationVisible && !dashboardViewModel.isKeyboardVisible {
                ZStack {
                    HStack(spacing: 0) {  // Add spacing of 0 to remove default padding between items
                        ForEach(TabItemEntity.allCases, id: \.self) { item in
                            Button {
                                tabRouter.selectedTab = item
                            } label: {
                                MyCustomTab(
                                    image: item.icon,
                                    title: item.title,
                                    isSelected: (tabRouter.selectedTab == item),
                                    bgColor: item.color
                                )
                                .frame(maxWidth: .infinity)  // Make each MyCustomTab expand to fill space
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)  // Ensure the HStack expands across the full screen width
                    .padding(5)
                }
                .frame(width: UIScreen.main.bounds.width * 0.90, height: 75)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.theme.blackAndWhite, lineWidth: 0.5)
                )
                .padding(.horizontal, 15)
                .padding(.bottom, 30)

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
    DashboardView()
        .environmentObject(TabRouter())
}
