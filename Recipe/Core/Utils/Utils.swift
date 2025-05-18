//
//  Utils.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
struct Utils{
    static let shared = Utils()
    
    func postDashboardNotifications(isDashboardBottomNavigationVisible: Bool){
        NotificationCenter.default.post(name: .dashboardVisibilityChanged, object: nil, userInfo: [Constants.isDashboardBottomNavigationVisible: isDashboardBottomNavigationVisible])
        print("DEBUG: postDashboardNotifications isDashboardBottomNavigationVisible \(isDashboardBottomNavigationVisible)")
    }
}
