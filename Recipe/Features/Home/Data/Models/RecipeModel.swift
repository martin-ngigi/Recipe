//
//  RecipeModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct RecipeModel: Codable, Hashable{
    let recipeId: String
    let openId: String
    let name: String
    let description: String
    let ingredients: [IngredientModel]
    let image: String
    let instructions: String
    var chef: ChefModel? = nil
    var inststuctionsList: [String]{
        return instructions.instructionsList
    }
    
    enum CodingKeys: String, CodingKey {
        case openId = "open_id"
        case name
        case description
        case ingredients = "ingredients_list"
        case image
        case instructions
        case recipeId = "recipe_id"
        case chef
    }
}

extension RecipeModel{
    
    static var dummyList: [RecipeModel] = RecipeDummyData.recipeList ?? []
}
