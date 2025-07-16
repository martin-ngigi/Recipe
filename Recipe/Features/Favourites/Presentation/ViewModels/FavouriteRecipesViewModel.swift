//
//  FavouriteRecipesViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation

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
    @Published var dialogEntity = DialogEntity()
    @Published var isShowAlertDialog = false
    @Published var shareState: FetchState = FetchState.good

    func addRecipeToFavourite(recipe: RecipeModel) async {
        favouriteRecipesUseCases.executeAddRecipe(recipe: recipe)
        let _ = await fetchFavouriteRecipes()
    }
    
    
    func fetchFavouriteRecipes() async {
        favouriteRecipes = favouriteRecipesUseCases.executeFetchRecipes()
        favouritesListViewTitle = favouriteRecipes.isEmpty ? "Favourites" : "\(favouriteRecipes.count) Favourites"
    }
    
    func deleteFavouriteRecipe(recipe: RecipeModel) async {
        favouriteRecipesUseCases.executeRemoveRecipe(recipe: recipe)
        let _ = await fetchFavouriteRecipes()
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
    
}
