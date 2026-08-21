/*
* Created by Martin Wainaina on 21/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationDetailView.swift
//  Recipe
//
//  Created by RAFIKI on 21/08/2026.
//

import SwiftUI

import SwiftUI

struct NotificationDetailView: View {

    let notification: NotificationModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    
                    HStack(alignment: .top, spacing: 14) {
                        Image(systemName: notification.isRead ? "envelope.open" : "envelope.badge")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundStyle(notification.isRead ? Color.secondary : Color.theme.primaryColor)
                            .frame(width: 56, height: 56)
                            .background {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(uiColor: .systemGray6),
                                                Color(uiColor: .systemGray3)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                            }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(notification.title ?? "")
                                .font(.custom("ProductSans-Medium", size: 18, relativeTo: .headline))
                                .foregroundStyle(Color.theme.blackAndWhite)

                            Text(notification.date ?? "")
                                .font(.custom("ProductSans-Medium", size: 13, relativeTo: .caption))
                                .foregroundStyle(Color.secondary)
                        }

                        Spacer()
                    }


                    VStack(alignment: .leading, spacing: 12) {
                        Text("Message")
                            .font(.custom("ProductSans-Medium", size: 16, relativeTo: .headline))
                            .foregroundStyle(Color.theme.blackAndWhite)

                        Text(notification.message ?? "")
                            .font(.custom("ProductSans-Light", size: 16, relativeTo: .body))
                            .foregroundStyle(Color.theme.blackAndWhite)
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Divider()

                        HStack {
                            Text("Status")
                                .font(.custom("ProductSans-Medium", size: 14, relativeTo: .subheadline))
                                .foregroundStyle(Color.secondary)

                            Spacer()

                            Text(notification.isRead ? "Read" : "Unread")
                                .font(.custom("ProductSans-Medium", size: 14, relativeTo: .subheadline))
                                .foregroundStyle(notification.isRead ? Color.secondary : Color.theme.primaryColor)
                        }

                        if notification.isStarred {
                            HStack {
                                Text("Starred")
                                    .font(.custom("ProductSans-Medium", size: 14, relativeTo: .subheadline))
                                    .foregroundStyle(Color.secondary)

                                Spacer()

                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundStyle(Color.theme.primaryColor)
                            }
                        }
                    }

                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Notification")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

}
//
//#Preview {
//    NotificationDetailView()
//}
