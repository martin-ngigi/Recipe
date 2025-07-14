//
//  RegisterViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase

// For apple auth
import CryptoKit
import AuthenticationServices

@MainActor
class RegisterViewModel : ObservableObject{
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var registeState: FetchState = FetchState.good
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isRegisterEnabled: Bool = false
    @Published var registerErrors = [String: String]()

    let firebaseAuthUseCase: FirebaseAuthUseCase = FirebaseAuthUseCase(
        createFirebaseUserRepository: FirebaseAuthRepository.shared,
        loginFirebaseRepository: FirebaseAuthRepository.shared,
        googleFirebaseAuthRepository: FirebaseAuthRepository.shared,
        resetPasswordFirebaseRepository: FirebaseAuthRepository.shared,
        logoutFirebaseRepository: FirebaseAuthRepository.shared,
        deleteFirebaseAccountRepository: FirebaseAuthRepository.shared
    )
    
    func updateEmail(value: String) {
        email = value
        let error = ValidatorUtils.shared.validateEmail(email: email)
        updateRegisterErrors(key: "email", value:  error)
    }

    
    func updatePassword(value: String) {
        password = value
        let errors = ValidatorUtils.shared.validatePassword(password: password)
        updateRegisterErrors(key: "password", value:  errors.first ?? "")
    }
    
    func updateName(value: String) {
        name = value
        let error = ValidatorUtils.shared.validateFullName(name: name)
        updateRegisterErrors(key: "name", value:  error)
    }
    
    func updateRegisterErrors(key: String, value: String) {
        registerErrors[key] = value
        validateIfLoginIsEnabled()
    }
    
    func validateIfLoginIsEnabled(){
        var isFormValid = true
        
        if !registerErrors.values.allSatisfy({ $0.isEmpty }) || email.isEmpty || password.isEmpty || name.isEmpty {
            isFormValid = false
        }
        
        isRegisterEnabled = isFormValid
    }
    
    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
    
    func updateRegisterState(value: FetchState) {
        registeState = value
    }
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
    
    func emailAndPasswordRegister(
        onSuccess: () -> Void,
        onFailure: (String) -> Void
    ) async {
        registeState = .isLoading
       
        var result:  Result<AuthDataResult, FirebaseAuthError>
        result = await firebaseAuthUseCase.executeCreateFirebaseUser(
            name: name,
            email: email,
            password: password
        )
        switch result {
        case .success(let authDataResult):
            print("DEBUG: Regiter success. User OpenId: \(authDataResult.user.uid)")
            onSuccess()
            registeState = .good
        case .failure(let error):
            registeState = .error(error.description)
            onFailure(error.description)
        }
        
    }
}
