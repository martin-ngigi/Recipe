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

    func removeRecipe(recipe: RecipeSwiftData) {
        modelContext.delete(recipe)
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to delete Book: \(error.localizedDescription)")
        }
    }
}
