//
//  LoginFirebaseRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import FirebaseAuth

protocol LoginFirebaseRepositoryProtocol {
    func loginFirebaseUser(email: String, password: String) async -> Result<AuthDataResult, FirebaseAuthError>
}
