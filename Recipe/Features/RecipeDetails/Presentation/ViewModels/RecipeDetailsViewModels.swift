//
//  RecipeDetailsViewModels.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import Foundation

@MainActor
class RecipeDetailsViewModels: ObservableObject {
    
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var isShowOpenShareSheet = false
    @Published var toast: Toast?
    @Published var shareState: FetchState = FetchState.good
    @Published var isShowIngredientImageOverlay = false
    @Published var ingredientImage: String?

    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }
    
    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }
    
    func updateIsShowOpenShareSheet(value: Bool) {
        isShowOpenShareSheet = value
    }
    
    func updateToast(value: Toast?) {
        toast = value
    }
    
    func updateShareState(value: FetchState) {
        shareState = value
    }
    
    func updateIsShowIngredientImageOverlay(value: Bool) {
        isShowIngredientImageOverlay = value
    }
    
    func updateIsIngredientImage(value: String) {
        ingredientImage = value
    }
}
