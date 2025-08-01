//
//  RecipeDetailsViewModels.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import Foundation

class RecipeDetailsViewModels: ObservableObject {
    
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var toast: Toast?
    @Published var shareState: FetchState = FetchState.good

    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
    
    func updateToast(value: Toast?) {
        toast = value
    }
    
    func updateShareState(value: FetchState) {
        shareState = value
    }
}
