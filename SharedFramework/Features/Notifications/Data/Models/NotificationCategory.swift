/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationCategory.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import Foundation

enum NotificationCategory: String, CaseIterable, Hashable {
    case inbox
    case promotions

    var title: String {
        switch self {
        case .inbox:
            return "Inbox"
        case .promotions:
            return "Promotions"
        }
    }

    var icon: String {
        switch self {
        case .inbox:
            return "tray"
        case .promotions:
            return "tag"
        }
    }
}
