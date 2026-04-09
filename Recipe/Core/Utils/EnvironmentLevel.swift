//
//  EnvironmentLevel.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import Foundation

/* MARK: Add in Info.plist file
<key>Configuration</key>
<string>${CONFIGURATION}</string>
*/

enum EnvironmentLevel {
    case production
    case debug

    static var current: EnvironmentLevel {
        let config = "\(Bundle.main.infoDictionary?["Configuration"] ?? "")"
        return config == "Debug" ? .debug : .production
    }

    static var isDebug: Bool {
        return current == .debug
    }

}
