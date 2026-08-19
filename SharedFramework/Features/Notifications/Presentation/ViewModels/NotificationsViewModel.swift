/*
* Created by Martin Wainaina on 19/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationsViewModel.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import Foundation
import Combine

enum NotificationsTabs: Int, CaseIterable {
    case all = 0
    case unread
    case read
    case starred

    var title: String {
        switch self {
        case .all:
            return "All"
        case .unread:
            return "Unread"
        case .read:
            return "Read"
        case .starred:
            return "Starred"
        }
    }

    var icon: String {
        switch self {
        case .all:
            return "bell"
        case .unread:
            return "bell.badge.fill"
        case .read:
            return "bell.badge"
        case .starred:
            return "star.fill"
        }
    }
}

struct NotificationsStates{
    var tabs = NotificationsTabs.allCases
    var selectedTab = NotificationsTabs.all
}

class NotificationsViewModel: ObservableObject{
    @Published var states = NotificationsStates()
}
