//
//  FirebaseAuthRepository.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase

// For apple auth
import CryptoKit
import AuthenticationServices

class FirebaseAuthRepository: CreateFirebaseUserRepositoryProtocol, LoginFirebaseRepositoryProtocol, GoogleFirebaseAuthRepositoryProtocol, ResetPasswordFirebaseRepositoryProtocol, LogoutFirebaseRepositoryProtocol, DeleteFirebaseAccountRepositoryProtocol {
    
    static let shared = FirebaseAuthRepository()
    
    func createFirebaseUser(name: String, email: String, password: String) async -> Result<AuthDataResult, FirebaseAuthError> {
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // update user's display name
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = name
            try await changeRequest.commitChanges()
            
            // send email verification link
            try await result.user.sendEmailVerification()
            
            return .success(result)
        }
        catch let error as NSError {
            
            /**
                if let error = error as NSError? {
                    let code = AuthErrorCode.Code(rawValue: error.code)
                    if code == .
                }
                // In above, after Typing the "." all the errors will be displayed.
            **/
            //switch AuthErrorCode.Code(rawValue: error.code) {
            switch AuthErrorCode(rawValue: error.code) {
            case .invalidEmail:
                return .failure(FirebaseAuthError.invalidEmail)
            case .weakPassword:
                return .failure(FirebaseAuthError.weakPassword)
            case .emailAlreadyInUse:
                return .failure(FirebaseAuthError.emailAlreadyInUse)
            default:
                return .failure(FirebaseAuthError.custom(error.localizedDescription))
            }
        }
        catch {
            /**
            let err = error as NSError
            if let authErrorCode = AuthErrorCode.Code(rawValue: err.code) {
                switch authErrorCode {
                case .wrongPassword:
                    print("wrong password")
                case .invalidEmail:
                    print("invalid email")
                // ... other cases
                default:
                    print("unknown error")
                }
            }
            **/
            return .failure(FirebaseAuthError.custom(error.localizedDescription))
        }

    }
    
    func loginFirebaseUser(email: String, password: String) async -> Result<AuthDataResult, FirebaseAuthError> {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return .success(result)
        }
        catch let error as NSError {
            /**
                if let error = error as NSError? {
                    let code = AuthErrorCode.Code(rawValue: error.code)
                    if code == .
                }
                // In above, after Typing the "." all the errors will be displayed.
            **/
            switch AuthErrorCode(rawValue: error.code) {
                case .invalidEmail:
                    return .failure(FirebaseAuthError.invalidEmail)
                case .userNotFound:
                    return .failure(FirebaseAuthError.userNotFound)
                case .userDisabled:
                    return .failure(FirebaseAuthError.userDisabled)
                case .invalidCredential:
                    return .failure(FirebaseAuthError.invalidCredential)
                case .wrongPassword:
                    return .failure(FirebaseAuthError.wrongPassword)
                default:
                    return .failure(FirebaseAuthError.custom(error.localizedDescription))
            }
        }
        catch {
            /**
            let err = error as NSError
            if let authErrorCode = AuthErrorCode.Code(rawValue: err.code) {
                switch authErrorCode {
                case .wrongPassword:
                    print("wrong password")
                case .invalidEmail:
                    print("invalid email")
                // ... other cases
                default:
                    print("unknown error")
                }
            }
            **/
            return .failure(FirebaseAuthError.custom(error.localizedDescription))
        }
    }
    
    func googleAuth() async -> Result<AuthDataResult, FirebaseAuthError> {
        do{
            // google sign in
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                //fatalError("No firebase Client ID")
                return .failure(FirebaseAuthError.custom("No firebase Client ID"))
            }
            
            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            // get rootView
            let scene = await UIApplication.shared.connectedScenes.first as? UIWindowScene
            guard let rootViewController = await scene?.windows.first?.rootViewController else {
                //fatalError("This is not root view controller")
                return .failure(FirebaseAuthError.custom("Error: This is not root view controller"))

            }
            
            // google sign in authentication response
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = result.user
            guard let idToken = user.idToken?.tokenString else {
                print("DEBUG: googleAuth Error no idToken")
                //fatalError("Unexpected error occurred, please retry")
                return .failure(FirebaseAuthError.custom("Error no idToken found."))

            }
            
            //Firebase auth
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            let authResult  = try await Auth.auth().signIn(with: credential)
            print ("Google Auth success. OpenID: \(authResult.user.uid)")
            return .success(authResult)
        }
        catch{
            print("Error: Failed to create google auth user with error \(error.localizedDescription)")
            return .failure(FirebaseAuthError.custom("Error: \(error.localizedDescription)"))
        }
    }
    
    func resetPassword(email: String) async -> Result<Bool, FirebaseAuthError> {
        do {
            let _ = try await Auth.auth().sendPasswordReset(withEmail: email)
            return .success(true)
        }
        catch {
            print("Error: Failed to reset Password with error \(error.localizedDescription)")
            return .failure(FirebaseAuthError.custom("Error: \(error.localizedDescription)"))
        }
    }
    
    func logout() -> Result<Bool, FirebaseAuthError> {
        do {
            try Auth.auth().signOut()
            return .success(true)
        }
        catch {
            print("Error: Failed to logout with error \(error.localizedDescription)")
            return .failure(FirebaseAuthError.custom("Error: \(error.localizedDescription)"))
        }
    }
    
    
    func deleteAccount() async -> Result<Bool, FirebaseAuthError> {
        do {
            try await Auth.auth().currentUser?.delete()
            return .success(true)
        }
        catch {
            print("Error: Failed to delete with error \(error.localizedDescription)")
            return .failure(FirebaseAuthError.custom("Error: \(error.localizedDescription)"))
        }
    }
    
}
