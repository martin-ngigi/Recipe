//
//  FavouriteRecipesRepository.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation

@MainActor
struct FavouriteRecipesRepository: @preconcurrency AddRecipeToLocalRepositoryProtocol, FetchLocalRecipesRepositoryProtocol, DeleteLocalRecipeRepositoryProtocol, DeleteAllLocalFavouritesRepositoryProtocol {
    
    static let shared = FavouriteRecipesRepository()

    let favouriteRecipesLocalDataSource = FavouriteRecipesLocalDataSource.shared

    @MainActor
    func addRecipe(recipe: RecipeModel) {
        let recipeSwiftData = RecipeSwiftData(model: recipe)
        favouriteRecipesLocalDataSource.addRecipe(recipe: recipeSwiftData)
    }
    
    func fetchRecipes() -> [RecipeModel] {
        let recipesSwift =  favouriteRecipesLocalDataSource.fetchRecipes()
        let recipes = recipesSwift.map{ RecipeModel(swiftData: $0)}
        return recipes
    }
    
    func removeRecipe(recipe: RecipeModel) {
        favouriteRecipesLocalDataSource.removeRecipe(recipe: recipe)
    }
    
    func deleteAllRecipes() {
        favouriteRecipesLocalDataSource.deleteAllRecipes()
    }
    
}
