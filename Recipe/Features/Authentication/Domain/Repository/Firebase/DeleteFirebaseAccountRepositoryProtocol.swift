//
//  DeleteFirebaseAccountRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import FirebaseAuth

protocol DeleteFirebaseAccountRepositoryProtocol {
    func deleteAccount() async -> Result<Bool, FirebaseAuthError>
}
