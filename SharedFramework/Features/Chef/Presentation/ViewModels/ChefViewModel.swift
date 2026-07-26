//
//  ChefViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation
import Combine

@MainActor
class ChefViewModel: ObservableObject {
    @Published var fetchChefByIDState = FetchState.good
    var chefUsesCases = ChefUseCases(chefRepository: ChefRepository.shared)
    @Published var isShowRating = false
    @Published var isShowChefImageOverlay = false
    @Published var isShowAllRecipeItems = false
    @Published var isShowAlertDialog = false
    @Published var dialogEntity = DialogEntity()
    @Published var chef: UserModel?
    @Published var user: UserModel?
    @Published var rating: Int = 0
    @Published var comment: String = ""

    func updateChef(chef: UserModel?) {
        self.chef = chef
    }

    func updateUser(user: UserModel?) {
        self.user = user
    }

    func fetchChefByID(
        chefId: String,
        onSuccess: (UserModel) -> Void,
        onFailure: (String) -> Void
    ) async {
        fetchChefByIDState = .isLoading

        let results = await chefUsesCases.executeFetchChefById(chefId: chefId)
        switch results {
        case .success(let response):
            fetchChefByIDState = .good
            onSuccess(response.data)
        case .failure(let error):
            fetchChefByIDState = .error(error.description)
            onFailure(error.localizedDescription)
        }
    }

    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }

    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }

    func updateIsShowChefImageOverlay(value: Bool) {
        isShowChefImageOverlay = value
    }

    deinit {}
}
