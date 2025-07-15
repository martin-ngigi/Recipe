//
//  AuthRepository.swift
//  Recipe
//
//  Created by Hummingbird on 14/07/2025.
//

import Foundation
import SwiftUI

struct AuthRepository: AuthenticateUserRepositoryProtocol, SaveUserToLocalRepositoryProtocol, GetLocalUserRepositoryProtocol{

    static let shared = AuthRepository()
    let authRemoteDataSource = AuthRemoteDataSource()
    let authLocalDataSource = AuthLocalDataSource.shared

    func authenticateUser(user: UserModel) async -> Result<UserResponseModel, APIError> {
        let results = await authRemoteDataSource.authenticateUser(user: user)
        
        switch results {
        case .success(let response):
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func saveUserToLocal(user: UserModel) {
        let userSwiftData = UserSwiftData(model: user)
        authLocalDataSource.saveUser(user: userSwiftData)
    }
    
    func getLocalUser() -> UserModel? {
        guard let swiftUserData = authLocalDataSource.fetchUser() else { return nil }
        return UserModel(swiftData: swiftUserData)
    }
    
}
