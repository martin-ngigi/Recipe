//
//  CreateFirebaseUserRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import FirebaseAuth
import Foundation

protocol CreateFirebaseUserRepositoryProtocol {
    func createFirebaseUser(
        name: String,
        email: String,
        password: String
    ) async -> Result<AuthDataResult, FirebaseAuthError>

}
