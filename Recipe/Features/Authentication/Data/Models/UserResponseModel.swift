//
//  UserResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 14/07/2025.
//

import Foundation

class UserResponseModel: Codable{
    let message: String
    let status_code: Int
    let user: UserModel?
}
