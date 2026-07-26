//
//  Utils.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
import os

struct Utils {
    static let shared = Utils()

    func postDashboardNotifications(isDashboardBottomNavigationVisible: Bool) {
        NotificationCenter.default.post(
            name: .dashboardVisibilityChanged,
            object: nil,
            userInfo: [Constants.isDashboardBottomNavigationVisible: isDashboardBottomNavigationVisible]
        )
        os.Logger().debug(
            "DEBUG: postDashboardNotifications isDashboardBottomNavigationVisible \(isDashboardBottomNavigationVisible)"
        )
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

    func decryptBase64(base64: String) -> String {
        if let data = Data(base64Encoded: base64) {
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }

    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).compactMap { _ in letters.randomElement() })
    }
}
