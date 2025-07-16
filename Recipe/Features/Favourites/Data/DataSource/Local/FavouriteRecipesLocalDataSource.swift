//
//  FavouriteRecipesLocalDataSource.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation
import SwiftData

final class FavouriteRecipesLocalDataSource{
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = FavouriteRecipesLocalDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: RecipeSwiftData.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func addRecipe(recipe: RecipeSwiftData) {
        modelContext.insert(recipe)
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save Book: \(error.localizedDescription)")
        }
    }

    func fetchRecipes() -> [RecipeSwiftData] {
        do {
            return try modelContext.fetch(FetchDescriptor<RecipeSwiftData>())
        } catch {
            fatalError("Failed to fetch Book: \(error.localizedDescription)")
        }
    }

    func removeRecipe(recipe: RecipeModel) {
        let recipes =  fetchRecipes()
        let recipeToDelete = recipes.first { $0.recipeId == recipe.recipeId }
        
        if let myRecipe = recipeToDelete {
            modelContext.delete(myRecipe)
            print("DEBUG: recipe \(myRecipe.name) found")
        }
        
        do {
            try modelContext.save()
            print("DEBUG: recipe \(recipe.name) deleted successfully")
        } catch {
            fatalError("Failed to delete Book: \(error.localizedDescription)")
        }
    }
    
    func deleteAllRecipes() {
        let allRecipes = fetchRecipes()
        
        for recipe in allRecipes {
            modelContext.delete(recipe)
        }
        
        do {
            try modelContext.save()
            print("DEBUG: All recipes deleted successfully.")
        } catch {
            fatalError("Failed to delete all recipes: \(error.localizedDescription)")
        }
    }

}
