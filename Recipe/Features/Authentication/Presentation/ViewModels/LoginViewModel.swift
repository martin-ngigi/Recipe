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
        if email.isEmpty{
            updateSendLoginErrors(key: "email", value:  "Invalid Email")
        }
        else {
            updateSendLoginErrors(key: "email", value:  "")
        }
    }

    
    func updatePassword(value: String) {
        password = value
        if email.isEmpty{
            updateSendLoginErrors(key: "password", value:  "Invalid Password")
        }
        else {
            updateSendLoginErrors(key: "password", value:  "")
        }
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
    
    func emailAndPasswordLogin() async{
       
        if password.isEmpty {
            updateSendLoginErrors(key: "password", value:  "Password Email")
            return
        }
        loginState = .isLoading
        
        var result: Result<AuthDataResult, FirebaseAuthError>
        result = await firebaseAuthUseCase.executeLoginFirebaseUser(email: email, password: password)
        
        switch result {
            case .success(let authDataResult):
                print("DEBUG: Login success. User OpenId: \(authDataResult.user.uid)")
                
                // Email not verified
                if !authDataResult.user.isEmailVerified {
                    loginState = .error("You need to verify your email. Check email verification link that was sent to \(authDataResult.user.email ?? "" ). If missing, check in Spam.")
                    return
                }
                
                loginState = .good
            
               // await authenticateUser(authDataResult: authDataResult, type: "Email")
            case .failure(let error):
                loginState = .error(error.description)
        }
        
    }

}
