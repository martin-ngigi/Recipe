//
//  LogoutFirebaseRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import FirebaseAuth
import Foundation

protocol LogoutFirebaseRepositoryProtocol {
    func logout() -> Result<Bool, FirebaseAuthError>
}
