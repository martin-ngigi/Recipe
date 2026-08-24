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

import SwiftUI

struct NotificationRowView: View {

    let title: String
    let message: String
    let date: String
    var isRead: Bool = true
    var isStarred: Bool = false
    var hasDivider: Bool = false
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 8) {
                
                Image(systemName: isRead ? "envelope.open" : "envelope.badge")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(isRead ? Color.secondary : Color.theme.primaryColor)
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

                VStack(alignment: .leading, spacing: 2) {
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .fontWeight(isRead ? .regular : .semibold)
                            .lineLimit(1)

                        Spacer(minLength: 4)

                        HStack{
                            Text(date)
                                .font(.appCaption2)
                                .foregroundStyle(isRead ? Color.secondary : Color.theme.primaryColor)
                                                        
                            if isStarred {
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                    .foregroundStyle(Color.theme.primaryColor)
                            }
                        }
                        
                    }

                    Text(message)
                        .font(.appCaption)
                        .foregroundStyle(Color.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    if hasDivider{
                        Divider()
                            .padding(.top, 8)
                    }
                }
                
            }
            .padding(.bottom, 8) // same as divider's padding
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .frame(minHeight: 44)
    }
}
