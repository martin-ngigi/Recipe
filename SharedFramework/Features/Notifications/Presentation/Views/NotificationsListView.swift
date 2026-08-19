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
    
    @StateObject var notificationsViewModel = NotificationsViewModel()
    
    var body: some View {
        List{
            
            Section{
                CustomTabsView(
                    tabs: $notificationsViewModel.states.tabs,
                    selectedTab: $notificationsViewModel.states.selectedTab,
                    onTap: { selectedTab, index in
                        os.Logger().debug("Selected tab: \(selectedTab.title) at index \(index)")
                    },
                    iconProvider: { tab in
                        let isSelected = notificationsViewModel.states.selectedTab == tab
                        let icon  = isSelected ? tab.icon : ""
                        return icon
                    },
                    labelProvider: { $0.title }
                )
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .ignoresSafeArea(edges: .horizontal)
            
            Section{
                TabView(selection: $notificationsViewModel.states.selectedTab) {
                    ContentUnavailableView(
                        "No Notifications Yet.",
                        systemImage: "bubble.left.and.bubble.right",
                        description:
                            Text("New notifications will appear here. \n\(Text("\(notificationsViewModel.states.selectedTab.title) is empty").font(.footnote).foregroundStyle(.tertiary))")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    )
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(minHeight: UIScreen.main.bounds.height * 0.5)
            }
            
        }
        .searchable(
            text: .constant("")
        )
        .searchToolbarBehavior(.minimize)
        .navigationTitle("Inbox")
        .navigationBarTitleDisplayMode(.large)
        .navigationSubtitle("Updated just now")
        .scrollEdgeEffectStyle(.soft, for: .top)
        .toolbar{
            
            ToolbarItem(placement: .bottomBar) {
                FilterPicker()
            }
            
            ToolbarSpacer(.flexible, placement: .bottomBar)

            DefaultToolbarItem(kind: .search, placement: .bottomBar)
            
            ToolbarItem(placement: .bottomBar) {
                Button{
                    
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
