//
//  RegisterViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
class RegisterViewModel : ObservableObject{
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var registeState: FetchState = FetchState.good
    
    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
    
    func updateRegisterState(value: FetchState) {
        registeState = value
    }
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
}
