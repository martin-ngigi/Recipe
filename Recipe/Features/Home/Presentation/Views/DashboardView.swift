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
                TabNavigationView(router: tabRouter.router) {
                    HomeView()
                }
                //.tag(0)
                .tag(TabItemEntity.home)
                
                
                
                TabNavigationView(router: tabRouter.router) {
                    FavouritesListView()
                }
                //.tag(1)
                .tag(TabItemEntity.favourites)
                
                TabNavigationView(router: tabRouter.router) {
                    SettingsScreen()
                }
                //.tag(2)
                .tag(TabItemEntity.settings)
                
                TabNavigationView(router: tabRouter.router) {
                    ProfileView()
                }
                //.tag(3)
                .tag(TabItemEntity.profile)
            }

            if isDashboardBottomNavigationVisible && !isKeyboardVisible {
                ZStack {
                    HStack(spacing: 0) { // Add spacing of 0 to remove default padding between items
                        ForEach(TabItemEntity.allCases, id: \.self) { item in
                            Button {
                                //dashboardViewModel.selectedTab = item.rawValue
                                tabRouter.selectedTab = item
                                print("DEBUG: tabRouter.selectedTab \(tabRouter.selectedTab), item \(item.rawValue)")
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
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            setUpDashboardVisibility()
            dashboardViewModel.selectedTab = 0
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
            
            Image(image)
                   .resizable()
                   .frame(width: 43, height: 43)
                   .padding(9)
                   //.background(isSelected ? Color.theme.primaryColor : bgColor)
                   .background(bgColor)
                   .cornerRadius(8)
                   .overlay(
                       RoundedRectangle(cornerRadius: 8) // Border around the image
                        .stroke(Color.gray, lineWidth: 1) // Set the border color and width
                   )
                   .overlay(
                          isSelected ?
                              Circle()
                                  .fill(Color.red)
                                  .frame(width: 10, height: 10)
                                  .offset(x: 22, y: -22)
                          : nil
                      )
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(TabRouter())
}
