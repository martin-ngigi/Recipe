//
//  IngredientModel.swift
//  Recipe
//
//  Created by Hummingbird on 03/07/2025.
//

import Foundation
import SwiftData

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

extension IngredientModel {
    init(swiftData: IngredientSwiftData) {
        self.ingredientID = swiftData.ingredientID
        self.name = swiftData.name
        self.image = swiftData.image
        self.quantity = swiftData.quantity
        self.recipeID = swiftData.recipeID
        self.createdAt = swiftData.createdAt
        self.updatedAt = swiftData.updatedAt
    }
}

@Model
final class IngredientSwiftData {
    var ingredientID: String
    var name: String
    var image: String
    var recipeID: String
    var createdAt: String
    var updatedAt: String
    var quantity: String
    
    var recipe: RecipeSwiftData?
    
    init(
        ingredientID: String,
        name: String,
        image: String,
        recipeID: String,
        createdAt: String,
        updatedAt: String,
        quantity: String,
        recipe: RecipeSwiftData? = nil
    ) {
        self.ingredientID = ingredientID
        self.name = name
        self.image = image
        self.recipeID = recipeID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.quantity = quantity
        self.recipe = recipe
    }
}

extension IngredientSwiftData {
    convenience init(model: IngredientModel) {
        self.init(
            ingredientID: model.ingredientID,
            name: model.name,
            image: model.image,
            recipeID: model.recipeID,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt,
            quantity: model.quantity,
            recipe: nil
        )
    }
}
