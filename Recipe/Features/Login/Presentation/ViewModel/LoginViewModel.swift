//
//  LoginViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation

class LoginViewModel : ObservableObject{
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var loginState: FetchState = FetchState.good
    
    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
    
    func updateLoginState(value: FetchState) {
        loginState = value
    }
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
}
