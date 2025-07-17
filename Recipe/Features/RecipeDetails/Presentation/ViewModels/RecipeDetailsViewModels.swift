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
    
    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
}
