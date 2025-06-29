//
//  Constants.swift
//  Recipe
//
//  Created by Hummingbird on 11/05/2025.
//

import Foundation

class Constants {
    static let isDashboardBottomNavigationVisible = "isDashboardBottomNavigationVisible"
    static let timeoutInterval: Double = 45
    static let accessToken: String = ""
    static let deviceId: String = ""
    static let PROD_URL = "https://safiribytes.com"
    static let IOS_TEST_URL: String = "http://127.0.0.1:8000"
    static let ANDROID_TEST_URL: String = "http://192.168.1.102:8000"
    static let prefix: String = "/api"
    static let homeURL: String = "\(prefix)/home"
    
    
    static var BASE_URL: String {
        #if DEBUG
            return IOS_TEST_URL
        #else
            return IOS_TEST_URL
        #endif
    }
    
    enum APIEdpoint {
        case home
        
        var url: URL? {
            switch self {
            case .home:
                return URL(string: "\(BASE_URL)\(homeURL)")
            }
        }
    }
}
