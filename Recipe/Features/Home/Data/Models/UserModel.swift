//
//  UserModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation
import SwiftData

struct UserModel: Codable, Hashable {
    let userID, name, email, openID: String
    let avatar, role: String
    let gender: String?
    let dateOfBirth: String?
    let phone: String?
    let phoneComplete: String?
    let countryCode: String?
    let token, accessToken, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, email
        case openID = "open_id"
        case avatar, role, gender
        case dateOfBirth = "date_of_birth"
        case phone
        case phoneComplete = "phone_complete"
        case countryCode = "country_code"
        case token
        case accessToken = "access_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension UserModel {
    init(swiftData: UserSwiftData) {
        self.userID = swiftData.userID
        self.name = swiftData.name
        self.email = swiftData.email
        self.openID = swiftData.openID
        self.avatar = swiftData.avatar
        self.role = swiftData.role
        self.gender = swiftData.gender
        self.dateOfBirth = swiftData.dateOfBirth
        self.phone = swiftData.phone
        self.phoneComplete = swiftData.phoneComplete
        self.countryCode = swiftData.countryCode
        self.token = swiftData.token
        self.accessToken = swiftData.accessToken
        self.createdAt = swiftData.createdAt
        self.updatedAt = swiftData.updatedAt
    }
}


@Model
class UserSwiftData {
    var userID: String
    var name: String
    var email: String
    var openID: String
    var avatar: String
    var role: String
    var gender: String? // Optional
    var dateOfBirth: String?
    var phone: String?
    var phoneComplete: String?
    var countryCode: String? // Optional
    var token: String
    var accessToken: String
    var createdAt: String
    var updatedAt: String

    init(userID: String, name: String, email: String, openID: String, avatar: String, role: String, gender: String? = nil, dateOfBirth: String? = nil, phone: String? = nil, phoneComplete: String? = nil, countryCode: String? = nil, token: String, accessToken: String, createdAt: String, updatedAt: String) {
        self.userID = userID
        self.name = name
        self.email = email
        self.openID = openID
        self.avatar = avatar
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.phoneComplete = phoneComplete
        self.countryCode = countryCode
        self.token = token
        self.accessToken = accessToken
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension UserSwiftData {
    convenience init(model: UserModel) {
        self.init(
            userID: model.userID,
            name: model.name,
            email: model.email,
            openID: model.openID,
            avatar: model.avatar,
            role: model.role,
            gender: model.gender,
            dateOfBirth: model.dateOfBirth,
            phone: model.phone,
            phoneComplete: model.phoneComplete,
            countryCode: model.countryCode,
            token: model.token,
            accessToken: model.accessToken,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt
        )
    }
}
