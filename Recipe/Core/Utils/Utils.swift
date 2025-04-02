//
//  Utils.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
struct Utils{
    static let shared = Utils()
    
    func postDashboardNotifications(isDashoardBottomNavigationVisible: Bool){
        NotificationCenter.default.post(name: .dashboardVisibilityChanged, object: nil, userInfo: ["isDashboardBottomNavVisible": isDashoardBottomNavigationVisible])
        print("DEBUG: postDashboardNotifications isDashoardBottomNavigationVisible \(isDashoardBottomNavigationVisible)")
    }
}
