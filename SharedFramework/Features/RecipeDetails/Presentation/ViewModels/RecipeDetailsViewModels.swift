/*
* Created by Martin Wainaina on 27/09/2026
*
* Feel free to contribute.
*/

//
//  RecipeDetailsViewModels.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import Foundation
import Combine

struct RecipeDetailsStates{
    var popNotificationData: PopNotificationData? = nil
    var isPopNotificationPresented: Bool = false
}

@MainActor
class RecipeDetailsViewModels: ObservableObject {

    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var isShowOpenShareSheet = false
    @Published var toast: Toast?
    @Published var shareState = FetchState.good
    @Published var isShowIngredientImageOverlay = false
    @Published var ingredientImage: String?

    @Published var recipe: RecipeModel?
    @Published var isShowAllItems = false
    @Published var states  = RecipeDetailsStates()

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
    
    func updatePopNotificationData(value: PopNotificationData) {
        states.popNotificationData = value
    }
    
    func updatePopNotificationData(data: PopNotificationData, isPresented: Bool ) {
        states.popNotificationData = data
        states.isPopNotificationPresented = isPresented
    }
   
    func updateIsPopNotificationPresented(value: Bool) {
        states.isPopNotificationPresented = value
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

    deinit {}
}
