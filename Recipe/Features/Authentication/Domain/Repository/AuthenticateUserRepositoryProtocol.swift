//
//  AuthenticateUserRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 14/07/2025.
//

import Foundation

protocol AuthenticateUserRepositoryProtocol {
    func authenticateUser(user: UserModel) async -> Result<UserResponseModel, APIError>
}
