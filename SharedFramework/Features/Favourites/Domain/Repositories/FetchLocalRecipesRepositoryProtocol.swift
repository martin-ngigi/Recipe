//
//  FetchLocalRecipesRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation

protocol FetchLocalRecipesRepositoryProtocol {
    func fetchRecipes() -> [RecipeModel]
}
