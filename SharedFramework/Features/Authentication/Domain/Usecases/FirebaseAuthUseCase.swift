//
//  FirebaseAuthUseCase.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import AuthenticationServices
// For apple auth
import CryptoKit
import FirebaseAuth
import Foundation

struct FirebaseAuthUseCase {

    let createFirebaseUserRepository: CreateFirebaseUserRepositoryProtocol
    let loginFirebaseRepository: LoginFirebaseRepositoryProtocol
    let googleFirebaseAuthRepository: GoogleFirebaseAuthRepositoryProtocol
    let resetPasswordFirebaseRepository: ResetPasswordFirebaseRepositoryProtocol
    let logoutFirebaseRepository: LogoutFirebaseRepositoryProtocol
    let deleteFirebaseAccountRepository: DeleteFirebaseAccountRepositoryProtocol

    func executeCreateFirebaseUser(
        name: String,
        email: String,
        password: String
    ) async -> Result<AuthDataResult, FirebaseAuthError> {
        return await createFirebaseUserRepository.createFirebaseUser(name: name, email: email, password: password)
    }

    func executeLoginFirebaseUser(email: String, password: String) async -> Result<AuthDataResult, FirebaseAuthError> {
        return await loginFirebaseRepository.loginFirebaseUser(email: email, password: password)
    }

    func executeGoogleAuth() async -> Result<AuthDataResult, FirebaseAuthError> {
        return await googleFirebaseAuthRepository.googleAuth()
    }

    func executeResetPassword(email: String) async -> Result<Bool, FirebaseAuthError> {
        return await resetPasswordFirebaseRepository.resetPassword(email: email)
    }

    func executeLogout() -> Result<Bool, FirebaseAuthError> {
        return logoutFirebaseRepository.logout()
    }

    func executeDeletAccount() async -> Result<Bool, FirebaseAuthError> {
        return await deleteFirebaseAccountRepository.deleteAccount()
    }

}
