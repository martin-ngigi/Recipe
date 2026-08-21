/*
* Created by Martin Wainaina on 16/08/2026
*
* Feel free to contribute.
*/

//
//  FavouriteRecipesViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation
import Combine

@MainActor
class FavouriteRecipesViewModel: ObservableObject {
    let favouriteRecipesUseCases = FavouriteRecipesUseCases(
        addRecipeToLocalRepository: FavouriteRecipesRepository.shared,
        fetchLocalRecipesRepository: FavouriteRecipesRepository.shared,
        deleteLocalRecipeRepository: FavouriteRecipesRepository.shared,
        deleteAllLocalFavouritesRepository: FavouriteRecipesRepository.shared
    )

    @Published var favouriteRecipes: [RecipeModel] = []
    @Published var favouritesListViewTitle = "Favourites"
    @Published var searchField = ""
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var shareState = FetchState.good
    @Published var toast: Toast?
    @Published var isLoading = false
    
    func updateIsLoading(value: Bool) async{
        isLoading = true
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        isLoading = false
    }

    func addRecipeToFavourite(recipe: RecipeModel) async {
        favouriteRecipesUseCases.executeAddRecipe(recipe: recipe)
        _ = await fetchFavouriteRecipes()
    }

    func fetchFavouriteRecipes() async {
        
        isLoading = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        favouriteRecipes = favouriteRecipesUseCases.executeFetchRecipes()
        favouritesListViewTitle = favouriteRecipes.isEmpty ? "Favourites" : "\(favouriteRecipes.count) Favourites"
        
        isLoading = false

    }

    func deleteFavouriteRecipe(recipe: RecipeModel) async {
        favouriteRecipesUseCases.executeRemoveRecipe(recipe: recipe)
        _ = await fetchFavouriteRecipes()
    }

    func updateDialogEntity(value: DialogEntity) {
        dialogEntity = value
    }

    func updateShareState(value: FetchState) {
        shareState = value
    }

    func updateIsShowAlertDialog(value: Bool) {
        isShowAlertDialog = value
    }

    func deleteAllFavourites() {
        favouriteRecipesUseCases.executeDeleteAllRecipes()
    }

    func checkIfIsInFavourites(recipe: RecipeModel) async -> Bool {
        await fetchFavouriteRecipes()
        return favouriteRecipes.contains { $0.recipeId == recipe.recipeId }
    }

    func sleep(nanoseconds: UInt64) async {
        try? await Task.sleep(nanoseconds: nanoseconds)  // 0.5 sec
    }

    func updateToast(value: Toast?) {
        toast = value
    }

    deinit {}
}
