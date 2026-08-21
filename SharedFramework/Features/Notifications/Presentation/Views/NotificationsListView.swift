/*
* Created by Martin Wainaina on 21/08/2026
*
* Feel free to contribute.
*/

import SwiftUI
import os

struct NotificationsListView: View {

    @StateObject private var notificationsViewModel = NotificationsViewModel()
    @State private var selectedNotification: NotificationModel?
    @State private var showNotification = false

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "Recipe",
        category: "Notifications"
    )

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                CustomTabsView(
                    tabs: $notificationsViewModel.states.tabs,
                    selectedTab: $notificationsViewModel.states.selectedTab,
                    onTap: { selectedTab, index in
                        notificationsViewModel.updateSelectedTab(value: selectedTab)
                        logger.debug("Selected tab: \(selectedTab.title) at index \(index)")
                    },
                    iconProvider: { tab in
                        let isSelected = notificationsViewModel.states.selectedTab == tab
                        return isSelected ? tab.icon : ""
                    },
                    labelProvider: { $0.title }
                )
                .padding(.bottom, 8)

                GroupedNotificationsView(
                    groups: notificationsViewModel.sortedNotificationGroups,
                    tab: notificationsViewModel.states.selectedTab,
                    onNotificationTap: { notification in
                        selectedNotification = notification
                        showNotification = true
                    }
                )
            }
            .padding(.horizontal, 16)
        }
        .background(Color(.systemGroupedBackground))
        .searchable(
            text: $notificationsViewModel.notificationsSearchText,
            prompt: "Search notifications"
        )
        .navigationTitle("Notifications")
        .navigationSubtitle("44 Unread")
        .navigationBarTitleDisplayMode(.large)
        .scrollEdgeEffectStyle(.soft, for: .top)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                FilterPicker()
            }

            ToolbarSpacer(.flexible, placement: .bottomBar)

            DefaultToolbarItem(kind: .search, placement: .bottomBar)

            ToolbarSpacer(.flexible, placement: .bottomBar)

            ToolbarItem(placement: .bottomBar) {
                Button {
                    // Compose new notification
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showNotification) {
            if let selectedNotification {
                NotificationDetailView(notification: selectedNotification)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsListView()
    }
}
