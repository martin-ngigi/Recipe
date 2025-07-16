//
//  ProfileViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import Foundation

class ProfileViewModel: ObservableObject{
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var profileState: FetchState = FetchState.good
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
    
    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
}
