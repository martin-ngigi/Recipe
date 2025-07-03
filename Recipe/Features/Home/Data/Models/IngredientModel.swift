//
//  IngredientModel.swift
//  Recipe
//
//  Created by Hummingbird on 03/07/2025.
//

import Foundation

// MARK: - IngredientModel
struct IngredientModel: Codable, Hashable {
    let ingredientID, name: String
    let image: String
    let quantity, recipeID, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case ingredientID = "ingredient_id"
        case name, image, quantity
        case recipeID = "recipe_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
