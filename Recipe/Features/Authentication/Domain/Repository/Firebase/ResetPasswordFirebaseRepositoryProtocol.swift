//
//  ResetPasswordFirebaseRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import FirebaseAuth

protocol ResetPasswordFirebaseRepositoryProtocol {
    func resetPassword(email: String) async -> Result<Bool, FirebaseAuthError>
}
