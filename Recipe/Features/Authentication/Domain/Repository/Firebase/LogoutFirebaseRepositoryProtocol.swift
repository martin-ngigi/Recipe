//
//  LogoutFirebaseRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import FirebaseAuth

protocol LogoutFirebaseRepositoryProtocol{
    func logout() -> Result<Bool, FirebaseAuthError>
}
