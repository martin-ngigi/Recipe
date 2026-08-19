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

struct NotificationsListView: View {
    var body: some View {
        List{
            ContentUnavailableView(
                "No Notifications Yet.",
                systemImage: "bubble.left.and.bubble.right",
                description: Text("New notifications will appear here.")
            )
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
