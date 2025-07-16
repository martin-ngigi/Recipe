//
//  AuthUseCases.swift
//  Recipe
//
//  Created by Hummingbird on 15/07/2025.
//

import Foundation

struct AuthUseCases{
    let authenticateUserRepository: AuthenticateUserRepositoryProtocol
    let getLocalUserRepository: GetLocalUserRepositoryProtocol
    let saveUserToLocalRepository: SaveUserToLocalRepositoryProtocol
    let deleteLocalUserRepository: DeleteLocalUserRepositoryProtocol
    
    init(authenticateUserRepository: AuthenticateUserRepositoryProtocol, getLocalUserRepository: GetLocalUserRepositoryProtocol, saveUserToLocalRepository: SaveUserToLocalRepositoryProtocol, deleteLocalUserRepository: DeleteLocalUserRepositoryProtocol) {
        self.authenticateUserRepository = authenticateUserRepository
        self.getLocalUserRepository = getLocalUserRepository
        self.saveUserToLocalRepository = saveUserToLocalRepository
        self.deleteLocalUserRepository = deleteLocalUserRepository
    }
    
    func executeAuthenticateUser(user: UserModel) async -> Result<UserResponseModel, APIError> {
        return await authenticateUserRepository.authenticateUser(user: user)
    }
    
    func excuteSaveUserToLocal(user: UserModel) {
        return saveUserToLocalRepository.saveUserToLocal(user: user)
    }
    
    func executeGetLocalUser() -> UserModel? {
        return getLocalUserRepository.getLocalUser()
    }
    
    func deleteLocalUser() {
        deleteLocalUserRepository.deleteLocalUser()
    }
}
