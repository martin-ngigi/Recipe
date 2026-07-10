//
//  DeviceInfo.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import Foundation
import SwiftUI

struct DeviceInfo {
    let deviceId: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let deviceType: String = UIDevice.current.userInterfaceIdiom == .phone ? "iPhone" : "iPad"
    let deviceName: String = UIDevice.current.name
    let iOSVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    let osVersion: String = UIDevice.current.systemVersion
}
