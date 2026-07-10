//
//  MyFirebaseAnalytics.swift
//  Recipe
//
//  Created by RAFIKI on 21/05/2026.
//

import FirebaseAnalytics
import Foundation
import os

class MyFirebaseAnalytics {
    static let shared = MyFirebaseAnalytics()

    // Log general Infor
    func logEvent(
        title: String,
        itemName: String = "",
        contentType: String = "",
        additionalInfo: [String: Any] = [:]
    ) {
        let defaultAdditionalInfo: [String: Any] = appInfor()

        var parameters: [String: Any] = [
            AnalyticsParameterItemID: "id-\(title)",
            AnalyticsParameterItemName: itemName.isEmpty ? title : itemName,
            AnalyticsParameterContentType: contentType
        ]

        let finalAdditionalInfo: [String: Any] = defaultAdditionalInfo.merging(additionalInfo) { _, new in new }

        parameters.merge(finalAdditionalInfo) { _, new in new }

        Analytics.logEvent(title, parameters: parameters)

        os.Logger().log(
            "DEBUG: Analytics event logged: \(title), contentType: \(contentType), additional: \(finalAdditionalInfo)"
        )
    }

    func logScreen(
        screen: String,
        screenClass: String = ""
    ) {
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [
                AnalyticsParameterScreenName: screen,
                AnalyticsParameterScreenClass: screenClass
            ]
        )
    }

    // Log sign-in event.
    func logLogin(method: String = "default") {
        Analytics.logEvent(
            AnalyticsEventLogin,
            parameters: [
                AnalyticsParameterMethod: method
            ]
        )
    }

    // Log sign-up event.
    func logSignUp(method: String = "default") {
        Analytics.logEvent(
            AnalyticsEventSignUp,
            parameters: [
                AnalyticsParameterMethod: method
            ]
        )
    }

    // Log searchs event.
    func logSearch(searchTerm: String) {
        Analytics.logEvent(
            AnalyticsEventSearch,
            parameters: [
                AnalyticsParameterSearchTerm: searchTerm
            ]
        )
    }

    // Log payment and checkout.
    func logBeginCheckout(value: Double, currency: String = "KES", items: [[String: Any]] = []) {
        Analytics.logEvent(
            AnalyticsEventBeginCheckout,
            parameters: [
                AnalyticsParameterCurrency: currency,
                AnalyticsParameterValue: value,
                AnalyticsParameterItems: items
            ]
        )
    }

    // Log complete a purchases.
    func logPurchase(transactionId: String, value: Double, currency: String = "KES", items: [[String: Any]] = []) {
        Analytics.logEvent(
            AnalyticsEventPurchase,
            parameters: [
                AnalyticsParameterTransactionID: transactionId,
                AnalyticsParameterValue: value,
                AnalyticsParameterCurrency: currency,
                AnalyticsParameterItems: items
            ]
        )
    }

    // Log errors
    func logError(message: String, screen: String = "") {
        Analytics.logEvent(
            "app_error",
            parameters: [
                "error_message": message,
                "screen": screen
            ]
        )
    }

    // Log  custom events.
    func logCustomEvent(name: String, parameters: [String: Any]) {
        Analytics.logEvent(name, parameters: parameters)
    }

    func setUserID(_ id: String) {
        Analytics.setUserID(id)
        os.Logger().log("DEBUG: analytics user_id is \(id)")
        os.os_log("DEBUG: analytics user_id is \(id)")
        os.os_log(.info, "DEBUG: analytics user_id is \(id)")
    }

    func appInfor() -> [String: Any] {
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? "--"
        let deviceName = UIDevice.current.name.removeEmojis()
        let deviceType = UIDevice.current.userInterfaceIdiom == .phone ? "iPhone" : "iPad"
        let osVersion = UIDevice.current.systemVersion
        let platform = "iOS"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let deviceDimensions = "\(UIScreen.main.bounds.width)(W) x \(UIScreen.main.bounds.height)(H)"
        let currentDate = "\(Date())"

        return [
            "device_id": deviceID,
            "app_version": appVersion,
            "device_type": deviceType,
            "os_version": osVersion,
            "platform": platform,
            "device_name": deviceName,
            "device_size_dimensions": deviceDimensions,
            "date": currentDate,
            "timestamp": Int(Date().timeIntervalSince1970),
            "other": "__"
        ]
    }

    deinit {}
}
