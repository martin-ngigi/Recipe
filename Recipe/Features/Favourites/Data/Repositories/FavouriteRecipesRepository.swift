//
//  FavouriteRecipesRepository.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation

@MainActor
struct FavouriteRecipesRepository: @preconcurrency AddRecipeToLocalRepositoryProtocol, FetchLocalRecipesRepositoryProtocol, DeleteLocalRecipeRepositoryProtocol {
    
    static let shared = FavouriteRecipesRepository()
//    private let dataSource: FavouriteRecipesLocalDataSource

    let favouriteRecipesLocalDataSource = FavouriteRecipesLocalDataSource.shared
    
//    init(dataSource: FavouriteRecipesLocalDataSource = .shared) {
//        self.dataSource = dataSource
//    }
    
    @MainActor
    func addRecipe(recipe: RecipeModel) {
        let recipeSwiftData = RecipeSwiftData(model: recipe)
        favouriteRecipesLocalDataSource.addRecipe(recipe: recipeSwiftData)
    }
    
    func fetchRecipes() -> [RecipeModel] {
        let recipesSwift =  favouriteRecipesLocalDataSource.fetchRecipes()
        let recipes = recipesSwift.map{ RecipeModel(swiftData: $0)}
        print("DEBUG: fetchRecipes \(recipesSwift.count), recipes \(recipes.count)")
        return recipes
    }
    
    func removeRecipe(recipe: RecipeModel) {
        favouriteRecipesLocalDataSource.removeRecipe(recipe: recipe)
    }
    
}
