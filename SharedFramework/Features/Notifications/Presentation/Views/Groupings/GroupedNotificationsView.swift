/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  GroupedNotificationsView.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import SwiftUI

struct GroupedNotificationsView: View {

    let groups: [(date: String, notifications: [NotificationModel])]
    let tab: NotificationsTabs

    var onNotificationTap: (NotificationModel) -> Void

    var body: some View {
        if groups.isEmpty {
            ContentUnavailableView(
                "No Notifications Yet.",
                systemImage: tab.icon,
                description: Text( "\(tab.title) notifications will appear here.")
            )
        }
        else {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                ForEach(groups, id: \.date) { group in
                    Section {
                        VStack(spacing: 0) {
                            ForEach(Array(group.notifications.enumerated()),id: \.element.id ) { index, notification in
                                NotificationRowView(
                                    title: notification.title ?? "",
                                    message: notification.message ?? "",
                                    date: notification.date?.extractTime() ?? "",
                                    isRead: notification.isRead,
                                    isStarred: notification.isStarred,
                                    onTap: {
                                        onNotificationTap(notification)
                                    }
                                )
                                .contextMenu(
                                    menuItems: {
                                        VStack{
                                            
                                            HStack{
                                                Button("", systemImage: "star"){
                                                    
                                                }
                                                
                                                Button("",systemImage: "arrowshape.turn.up.right"){

                                                }
                                            }
                                            
                                            Button("Mark as read",systemImage: "eye.fill"){

                                            }
                                        }
                                    },
                                    preview: {
                                        NotificationPreview(notification: notification)
                                            .padding()
                                            .frame(width: UIScreen.main.bounds.width * 0.7, height: 300)
                                            .background(.background)
                                    }
                                )
                                
                                if index < group.notifications.count - 1 {
                                    Divider()
                                        .padding(.leading, 72)
                                }
                            }
                        }
                        .padding(8)
                        .background(Color(.secondarySystemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 24))

                    } header: {
                        NotificationHeaderView( date: group.date )
                    }
                }
            }
            .padding(.vertical, 16)
        }
    }
}

//#Preview {
//    AllNotificationsView()
//}
