//
//  LoginViewModel.swift
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

@MainActor
class LoginViewModel : ObservableObject{
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var loginState: FetchState = FetchState.good
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled: Bool = false
    @Published var loginErrors = [String: String]()

    let firebaseAuthUseCase: FirebaseAuthUseCase = FirebaseAuthUseCase(
        createFirebaseUserRepository: FirebaseAuthRepository.shared,
        loginFirebaseRepository: FirebaseAuthRepository.shared,
        googleFirebaseAuthRepository: FirebaseAuthRepository.shared,
        resetPasswordFirebaseRepository: FirebaseAuthRepository.shared,
        logoutFirebaseRepository: FirebaseAuthRepository.shared,
        deleteFirebaseAccountRepository: FirebaseAuthRepository.shared
    )
    
    let authUseCases = AuthUseCases(
        authenticateUserRepository: AuthRepository.shared,
        getLocalUserRepository: AuthRepository.shared,
        saveUserToLocalRepository: AuthRepository.shared
    )
    
    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
    
    func updateLoginState(value: FetchState) {
        loginState = value
    }
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
    
    func updateEmail(value: String) {
        email = value
        let error = ValidatorUtils.shared.validateEmail(email: email)
        updateSendLoginErrors(key: "email", value:  error)

    }

    
    func updatePassword(value: String) {
        password = value
        let errors = ValidatorUtils.shared.validatePassword(password: password)
        updateSendLoginErrors(key: "password", value:  errors.first ?? "")
    }
    
    func updateSendLoginErrors(key: String, value: String) {
        loginErrors[key] = value
        validateIfLoginIsEnabled()
    }
    
    func validateIfLoginIsEnabled(){
        var isFormValid = true
        
        if !loginErrors.values.allSatisfy({ $0.isEmpty }) || email.isEmpty || password.isEmpty {
            isFormValid = false
        }
        
        isLoginEnabled = isFormValid
    }
    
    func emailAndPasswordLogin(
        onSuccess: () -> Void,
        onFailure: (String) -> Void
    ) async{
       
        loginState = .isLoading
        
        var result: Result<AuthDataResult, FirebaseAuthError>
        result = await firebaseAuthUseCase.executeLoginFirebaseUser(email: email, password: password)
        
        switch result {
            case .success(let authDataResult):
                print("DEBUG: Login success. User OpenId: \(authDataResult.user.uid)")
                
                // Email not verified
                if !authDataResult.user.isEmailVerified {
                    let errorMessage = "You need to verify your email. Check email verification link that was sent to \(authDataResult.user.email ?? "" ). If missing, check in Spam."
                    loginState = .error(errorMessage)
                    print("DEBUG: \(errorMessage)")
                    onFailure(errorMessage)
                    return
                }
                
                loginState = .good
            
            await authenticateUser(
                authDataResult: authDataResult,
                type: "Email",
                onSuccess: {
                    onSuccess()
                },
                onFailure: { error in
                    onFailure(error)
                }
            )
            case .failure(let error):
                loginState = .error(error.description)
                onFailure(error.description)
        }
        
    }
    
    func authenticateUser(
        authDataResult: AuthDataResult,
        type: String,
        onSuccess: () -> Void,
        onFailure: (String) -> Void
    ) async {
        
        let randomString = RandomStringGenerator.shared.randomString(length: 8)
        
        let name = authDataResult.user.displayName ?? "No_Name_\(randomString)"
        let email = authDataResult.user.email ?? "no_email_\(randomString)@safiribytes.com"
        let avatar = "/images/profile/default.png"
        let openId = authDataResult.user.uid
        let role = "Customer"
        
        let user: UserModel = UserModel(
            userID: "",
            name: name,
            email: email,
            openID: openId,
            authType: type,
            avatar: avatar,
            role: role
        )
        
        let result = await authUseCases.executeAuthenticateUser(user: user)
        
        switch result {
        case .success(let response):
            loginState = .good
            
            guard let userModel = response.user else {
                loginState = .error("Something went wrong while authenticating you. Please try again later.")
                return
            }
            
            let _ = authUseCases.excuteSaveUserToLocal(user: userModel)
            Constants.accessToken = userModel.accessToken ?? "No accessToken"
            Constants.openId = userModel.openID
            onSuccess()
        case .failure(let error):
            loginState = .error(error.description)
            onFailure(error.description)
        }
        
    }


}
