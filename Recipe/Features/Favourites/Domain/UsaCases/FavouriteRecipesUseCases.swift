//
//  FavouriteRecipesUseCases.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation

@MainActor
struct FavouriteRecipesUseCases{
    let addRecipeToLocalRepository: AddRecipeToLocalRepositoryProtocol
    let fetchLocalRecipesRepository: FetchLocalRecipesRepositoryProtocol
    let deleteLocalRecipeRepository: DeleteLocalRecipeRepositoryProtocol
    
    init(addRecipeToLocalRepository: AddRecipeToLocalRepositoryProtocol, fetchLocalRecipesRepository: FetchLocalRecipesRepositoryProtocol, deleteLocalRecipeRepository: DeleteLocalRecipeRepositoryProtocol) {
        self.addRecipeToLocalRepository = addRecipeToLocalRepository
        self.fetchLocalRecipesRepository = fetchLocalRecipesRepository
        self.deleteLocalRecipeRepository = deleteLocalRecipeRepository
    }
    
    func executeAddRecipe(recipe: RecipeModel){
        return addRecipeToLocalRepository.addRecipe(recipe: recipe)
    }
    
    func executeFetchRecipes() -> [RecipeModel] {
        return fetchLocalRecipesRepository.fetchRecipes()
    }
    
    func executeRemoveRecipe(recipe: RecipeModel) {
        deleteLocalRecipeRepository.removeRecipe(recipe: recipe)
    }
}
