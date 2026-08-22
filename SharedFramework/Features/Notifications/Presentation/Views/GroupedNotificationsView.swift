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
                                    hasDivider: index < group.notifications.count - 1,
                                    onTap: {
                                        onNotificationTap(notification)
                                    }
                                )
                                .scrollTransition { effect, phase in
                                    effect.scaleEffect(1 - abs(phase.value) * 0.2)
                                }
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
                                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 300)
                                            .background(.background)
                                    }
                                )
                                .swipeActions(edge: .leading) {
                                    Button {
                                        
                                    } label: {
                                        if notification.isRead {
                                            Label("Read", systemImage: "envelope.open")
                                        }
                                        else {
                                            Label("Unread", systemImage: "envelope.badge")
                                        }
                                    }
                                }
                                .swipeActions(edge: .trailing) {
                                    
                                    Button(role: .destructive) {
                                    
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Label("Flag", systemImage: "flag")
                                    }
                                }

                            }
                        }
                        .padding(16)
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
