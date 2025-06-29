//
//  RecipeModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct RecipeModel: Codable, Hashable{
    let recipeId: String
    let name: String
    let description: String
    let ingredients: String
    let image: String?
    let chefId: String
    let instructions: String
    let chef: ChefModel? = nil
    
    enum CodingKeys: String, CodingKey {
        case recipeId = "recipe_id"
        case name
        case description
        case ingredients
        case image
        case chefId = "chef_id"
        case instructions
        case chef
    }
}
