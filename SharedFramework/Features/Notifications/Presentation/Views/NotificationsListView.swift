/*
* Created by Martin Wainaina on 19/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationsListView.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import SwiftUI
import os


struct NotificationsListView: View {

    @StateObject private var notificationsViewModel =
        NotificationsViewModel()

    @State private var selectedNotification: NotificationModel?
    @State private var showNotification = false

    var body: some View {

        VStack {

            CustomTabsView(
                tabs: $notificationsViewModel.states.tabs,
                selectedTab:
                    $notificationsViewModel.states.selectedTab,
                onTap: { selectedTab, index in
                    notificationsViewModel.updateSelectedTab(value: selectedTab)
                    os.Logger().debug("Selected tab: \(selectedTab.title) at index \(index)")
                },
                iconProvider: { tab in
                    let isSelected = notificationsViewModel.states.selectedTab == tab
                    return isSelected ? tab.icon : ""
                },
                labelProvider: {
                    $0.title
                }
            )

            TabView(selection: $notificationsViewModel.states.selectedTab) {
                ForEach(NotificationsTabs.allCases,id: \.self) { tab in
                    ScrollView(showsIndicators: false) {
                        GroupedNotificationsView(
                            groups: notificationsViewModel.sortedNotificationGroups,
                            tab: tab,
                            onNotificationTap: { notification in
                                selectedNotification = notification
                                showNotification = true
                            }
                        )
                    }
                    .tag(tab)
                }
            }
            .tabViewStyle( PageTabViewStyle(indexDisplayMode: .never))
            .frame( minHeight:UIScreen.main.bounds.height * 0.7)
        }
        .searchable(
            text: $notificationsViewModel.notificationsSearchText,
            prompt: "Search notifications"
        )
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.large)
        .scrollEdgeEffectStyle(.soft, for: .top)
        .toolbar {

            ToolbarItem(placement: .bottomBar) {
                FilterPicker()
            }

            ToolbarSpacer( .flexible, placement: .bottomBar)

            DefaultToolbarItem(kind: .search, placement: .bottomBar)

            ToolbarItem(placement: .bottomBar) {

                Button {

                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

#Preview {
    NotificationsListView()
}
