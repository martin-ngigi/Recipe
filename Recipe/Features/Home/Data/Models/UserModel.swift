//
//  UserModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation

struct UserModel: Codable, Hashable {
    let userID, name, email, openID: String
    let avatar, role: String
    let gender, dateOfBirth, phone, phoneComplete: JSONNull?
    let countryCode: JSONNull?
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
