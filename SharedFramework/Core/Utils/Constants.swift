//
//  Constants.swift
//  Recipe
//
//  Created by Hummingbird on 11/05/2025.
//

import Foundation

enum Constants {

    enum APIEndpoint {
        case home
        case getChefById(chefId: String)
        case auth
        case searchAll(searchTerm: String)
        case createUpdateRate

        var url: URL? {
            switch self {
            case .home:
                return URL(string: "\(Constants.BASE_URL)\(Constants.homeURL)")

            case .getChefById(let chefId):
                return URL(string: "\(Constants.BASE_URL)\(Constants.getChefByIdURL)?open_id=\(chefId)")

            case .auth:
                return URL(string: "\(Constants.BASE_URL)\(Constants.authURL)")

            case .searchAll(let searchTerm):
                return URL(string: "\(Constants.BASE_URL)\(Constants.searchAllURL)?searchTerm=\(searchTerm)")

            case .createUpdateRate:
                return URL(string: "\(Constants.BASE_URL)\(Constants.createUpdateRateURL)")
            }
        }
    }

    static let isDashboardBottomNavigationVisible = "isDashboardBottomNavigationVisible"
    static let timeoutInterval: Double = 45
    static var accessToken: String = ""
    static var openId: String = ""
    static let deviceId: String = ""

    static let PROD_URL = Utils.shared.decryptBase64(base64: "aHR0cHM6Ly9yZWNpcGUuc2FmaXJpYnl0ZXMuY29t")
    static let IOS_TEST_URL = Utils.shared.decryptBase64(base64: "aHR0cDovLzEyNy4wLjAuMTo4MDAw")
    static let ANDROID_TEST_URL = Utils.shared.decryptBase64(base64: "aHR0cDovLzE5Mi4xNjguMS4xMDI6ODAwMA==")

    static let prefix = "/api"

    static let homeURL = "\(prefix)/home"
    static let getChefByIdURL = "\(prefix)/chefs/get-by-id"
    static let authURL = "\(prefix)/auth/authentication"
    static let searchAllURL = "\(prefix)/home/search"
    static let createUpdateRateURL = "\(prefix)/rates/create-update"

    static let APP_NAME = "Recipe"

    static var BASE_URL: String {
        if EnvironmentLevel.isDebug {
            return IOS_TEST_URL
        }
        else {
            return PROD_URL
        }
    }

}
