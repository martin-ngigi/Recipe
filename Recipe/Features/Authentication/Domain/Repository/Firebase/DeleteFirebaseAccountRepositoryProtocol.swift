//
//  DeleteFirebaseAccountRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import FirebaseAuth
import Foundation

protocol DeleteFirebaseAccountRepositoryProtocol {
    func deleteAccount() async -> Result<Bool, FirebaseAuthError>
}
