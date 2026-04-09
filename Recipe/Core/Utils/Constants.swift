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
    static var accessToken: String = ""
    static var openId: String = ""
    static let deviceId: String = ""
    static let PROD_URL = Utils.shared.decryptBase64(base64: "aHR0cHM6Ly9yZWNpcGUuc2FmaXJpYnl0ZXMuY29t")
    static let IOS_TEST_URL: String = Utils.shared.decryptBase64(base64: "aHR0cDovLzEyNy4wLjAuMTo4MDAw")
    static let ANDROID_TEST_URL: String = Utils.shared.decryptBase64(base64:"aHR0cDovLzE5Mi4xNjguMS4xMDI6ODAwMA==")
    
    static let prefix: String = "/api"
    
    static let homeURL: String = "\(prefix)/home"
    static let getChefByIdURL: String = "\(prefix)/chefs/get-by-id"
    static let authURL: String = "\(prefix)/auth/authentication"
    static let searchAllURL: String = "\(prefix)/home/search"
    static let createUpdateRateURL: String = "\(prefix)/rates/create-update"

    static let APP_NAME = "Recipe"
    
    static var BASE_URL: String {
        if EnvironmentLevel.isDebug {
            return IOS_TEST_URL
        }
        else {
            return PROD_URL
        }
    }
    
    enum APIEndpoint {
        case home
        case getChefById(chefId: String)
        case auth
        case searchAll(searchTerm: String)
        case createUpdateRate
        
        var url: URL? {
            switch self {
            case .home:
                return URL(string: "\(BASE_URL)\(homeURL)")
            case .getChefById(let chefId):
                return URL(string: "\(BASE_URL)\(getChefByIdURL)?open_id=\(chefId)")
            case .auth:
                return URL(string: "\(BASE_URL)\(authURL)")
            case .searchAll(let searchTerm):
                return URL(string: "\(BASE_URL)\(searchAllURL)?searchTerm=\(searchTerm)")
            case .createUpdateRate:
                return URL(string: "\(BASE_URL)\(createUpdateRateURL)")
            }
        }
    }
}
