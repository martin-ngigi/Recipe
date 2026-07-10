//
//  LoginFirebaseRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import FirebaseAuth
import Foundation

protocol LoginFirebaseRepositoryProtocol {
    func loginFirebaseUser(email: String, password: String) async -> Result<AuthDataResult, FirebaseAuthError>
}
