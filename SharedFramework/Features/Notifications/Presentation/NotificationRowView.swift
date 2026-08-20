/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationRowView.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import SwiftUI

struct NotificationRowView: View {

    let title: String
    let message: String
    let date: String

    var isRead: Bool = true
    var isStarred: Bool = false

    var onTap: () -> Void

    var body: some View {

        Button(action: onTap) {

            HStack(
                alignment: .top,
                spacing: 12
            ) {

                Image(
                    systemName: isRead
                    ? "envelope.open"
                    : "envelope.badge"
                )
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(
                    isRead
                    ? Color.secondary
                    : Color.theme.primaryColor
                )
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

                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {

                    HStack(
                        alignment: .firstTextBaseline,
                        spacing: 8
                    ) {

                        Text(title)
                            .font(
                                .custom(
                                    "ProductSans-Medium",
                                    size: 16,
                                    relativeTo: .callout
                                )
                            )
                            .foregroundStyle(
                                Color.theme.blackAndWhite
                            )
                            .fontWeight(
                                isRead ? .regular : .semibold
                            )
                            .lineLimit(1)

                        Spacer(minLength: 4)

                        Text(date)
                            .font(
                                .custom(
                                    "ProductSans-Medium",
                                    size: 12
                                )
                            )
                            .foregroundStyle(
                                isRead
                                ? Color.secondary
                                : Color.theme.primaryColor
                            )
                    }

                    Text(message)
                        .font(
                            .custom(
                                "ProductSans-Light",
                                size: 14,
                                relativeTo: .subheadline
                            )
                        )
                        .foregroundStyle(
                            Color.theme.blackAndWhite
                        )
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)

                }

                if isStarred {

                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(
                            Color.theme.primaryColor
                        )
                }
            }
            .padding(8)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .frame(minHeight: 44)
    }
}
