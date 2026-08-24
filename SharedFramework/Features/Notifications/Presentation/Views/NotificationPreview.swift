/*
* Created by Martin Wainaina on 22/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationPreview.swift
//  Recipe
//
//  Created by RAFIKI on 22/08/2026.
//

import SwiftUI

struct NotificationPreview: View {
    let notification: NotificationModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
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
                            .font(.appHeadline)
                            .foregroundStyle(Color.theme.blackAndWhite)

                        Text(notification.date ?? "")
                            .font(.appCaption)
                            .foregroundStyle(Color.secondary)
                    }

                    Spacer()
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Message")
                        .font(.appHeadline)
                        .foregroundStyle(Color.theme.blackAndWhite)

                    Text(notification.message ?? "")
                        .font(.appBody)
                        .foregroundStyle(Color.theme.blackAndWhite)
                        .lineSpacing(4)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}
