//
//  UserResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 14/07/2025.
//

import Foundation

struct UserResponseModel: Codable {
    let message: String
    let statusCode: String
    let user: UserModel?
    
    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        user = try? container.decode(UserModel.self, forKey: .user)
        
        if let intValue = try? container.decode(Int.self, forKey: .statusCode) {
            statusCode = String(intValue)
        } else {
            statusCode = try container.decode(String.self, forKey: .statusCode)
        }
    }
}
