//
//  ProfileViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var profileState = FetchState.good
    @Published var user: UserModel?

    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }

    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }

    func updateUser(value: UserModel?) {
        user = value
    }

    deinit {}
}
