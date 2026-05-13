//
//  GoogleFirebaseAuthRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import FirebaseAuth
import Foundation

protocol GoogleFirebaseAuthRepositoryProtocol {
    func googleAuth() async -> Result<AuthDataResult, FirebaseAuthError>
}
