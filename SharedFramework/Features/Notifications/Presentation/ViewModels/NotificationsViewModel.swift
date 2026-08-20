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
    case inbox
    case promotions
    case starred

    var title: String {
        switch self {
        case .all:
            return "All"
        case .inbox:
            return "Inbox"
        case .promotions:
            return "Promotions"
        case .starred:
            return "Starred"
        }
    }

    var icon: String {
        switch self {
        case .all:
            return "bell"
        case .inbox:
            return "tray"
        case .promotions:
            return "tag"
        case .starred:
            return "star.fill"
        }
    }
}

enum NotificationsFilter: Int, CaseIterable {
    case all = 0
    case unread
    case read

    var title: String {
        switch self {
        case .all:
            return "All"
        case .unread:
            return "Unread"
        case .read:
            return "Read"

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
        }
    }
}

struct NotificationsStates{
    var tabs = NotificationsTabs.allCases
    var selectedTab = NotificationsTabs.all
}

final class NotificationsViewModel: ObservableObject {

    @Published var states = NotificationsStates()

    @Published var notificationsSearchText = ""

    @Published var selectedFilter: NotificationsFilter = .all

    private(set) var notifications: [NotificationModel] =
        NotificationModel.dummyNotifications

    var selectedTab: NotificationsTabs {
        states.selectedTab
    }

    var filteredNotifications: [NotificationModel] {

        var result = notifications

        // Main tab
        switch states.selectedTab {

        case .all:
            break

        case .inbox:
            result = result.filter {
                $0.category == .inbox
            }

        case .promotions:
            result = result.filter {
                $0.category == .promotions
            }

        case .starred:
            result = result.filter {
                $0.isStarred
            }
        }

        // Read/unread filter
        switch selectedFilter {

        case .all:
            break

        case .unread:
            result = result.filter {
                !$0.isRead
            }

        case .read:
            result = result.filter {
                $0.isRead
            }
        }

        // Search
        let searchText = notificationsSearchText
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !searchText.isEmpty else {
            return result
        }

        return result.filter { notification in

            notification.title?.localizedCaseInsensitiveContains(searchText) ?? false
            ||
            notification.message?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }

    // MARK: - Grouping

    var groupedAlertsAndNotificationsList:
        [String: [NotificationModel]] {

        Dictionary(
            grouping: filteredNotifications
        ) { notification in

            notification.date?
                .formattedNotificationDate()
                ?? "Unknown Date"
        }
    }

    // MARK: - Sorted Groups

    var sortedNotificationGroups:
        [(date: String, notifications: [NotificationModel])] {

        groupedAlertsAndNotificationsList
            .compactMap { key, notifications in

                guard let date = key.toDate() else {
                    return nil
                }

                return (
                    date: key,
                    notifications: notifications.sorted {
                        guard
                            let lhsDate = $0.date?.toDate(),
                            let rhsDate = $1.date?.toDate()
                        else {
                            return false
                        }

                        return lhsDate > rhsDate
                    }
                )
            }
            .sorted { lhs, rhs in

                guard
                    let lhsDate = lhs.date.toDate(),
                    let rhsDate = rhs.date.toDate()
                else {
                    return false
                }

                return lhsDate > rhsDate
            }
    }

    // MARK: - Actions

    func updateSelectedTab(value: NotificationsTabs) {
        states.selectedTab = value
    }

    func updateSelectedFilter(value: NotificationsFilter) {
        selectedFilter = value
    }

    func updateSearchText(_ value: String) {
        notificationsSearchText = value
    }
}
