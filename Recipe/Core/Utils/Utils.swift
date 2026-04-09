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
    
    func formatPrettyJSON(data: Data?) -> String {

        guard let data = data, !data.isEmpty else {
            return "Empty"
        }

        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])

            if let prettyString = String(data: prettyData, encoding: .utf8) {
                return prettyString
            }
        }
        catch {

        }

        return String(data: data, encoding: .utf8) ?? "\(data)"
    }
}
