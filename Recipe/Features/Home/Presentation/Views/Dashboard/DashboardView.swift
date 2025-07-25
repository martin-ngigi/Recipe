//
//  DashboardView.swift
//  Recipe
//
//  Created by Martin on 24/03/2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var dashboardViewModel = DashboardViewModel()
    @State var isDashboardBottomNavigationVisible : Bool = true
    @State var isKeyboardVisible : Bool = false
    @EnvironmentObject var tabRouter: TabRouter

    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $tabRouter.selectedTab) {
                HomeView()
                    .tag(TabItemEntity.home)
                
                FavouritesListView()
                    .tag(TabItemEntity.favourites)
                
                SettingsScreen()
                    .tag(TabItemEntity.settings)
                
                Group{
                    if LocalState.isLogedIn {
                        ProfileView(
                            onLogoutSuccess: {
                                LocalState.isLogedIn = false
                                tabRouter.selectedTab = .profile
                            },
                            onLogoutFailed: {error in
                                
                            }
                        )
                    }
                    else {
                        LoginView(
                            onLoginSuccess: {
                                LocalState.isLogedIn = true
                                tabRouter.selectedTab = .profile
                            },
                            onLoginFailure: { error in
                                
                            }
                        )
                    }
                }
                .tag(TabItemEntity.profile)
            }

            if isDashboardBottomNavigationVisible && !isKeyboardVisible {
                ZStack {
                    HStack(spacing: 0) { // Add spacing of 0 to remove default padding between items
                        ForEach(TabItemEntity.allCases, id: \.self) { item in
                            Button {
                                tabRouter.selectedTab = item
                            } label: {
                                MyCustomTab(image: item.icon, title: item.title, isSelected: (tabRouter.selectedTab == item), bgColor: item.color)
                                    .frame(maxWidth: .infinity) // Make each MyCustomTab expand to fill space
                            }
                        }
                    }
                    .frame(maxWidth: .infinity) // Ensure the HStack expands across the full screen width
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
            if let isVisible = notification.userInfo?[Constants.isDashboardBottomNavigationVisible] as? Bool {
                isDashboardBottomNavigationVisible = isVisible
                print("DEBUG: setUpDashboardVisibility  isDashboardBottomNavigationVisible \(isDashboardBottomNavigationVisible)")
            }
        }
    }
}

extension DashboardView{
    func MyCustomTab(image: String, title: String, isSelected: Bool, bgColor: Color) -> some View{
        VStack{
            
            Image(systemName: image)
                   .resizable()
                   .frame(width: 43, height: 43)
                   .padding(9)
                   .background(isSelected ? Color.theme.primaryColor : Color.gray)
                   .foregroundColor(isSelected ? Color.theme.blackAndWhite : Color.theme.whiteAndBlack )
                   .cornerRadius(8)
//                   .overlay(
//                       Rectangle()
//                           .frame(height: 2)
//                           .foregroundColor(isSelected ? Color.theme.primaryColor : Color.clear),
//                       alignment: .bottom
//                   )
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(TabRouter())
}
