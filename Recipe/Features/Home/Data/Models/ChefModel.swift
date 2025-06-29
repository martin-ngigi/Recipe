//
//  ChefModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct ChefModel: Codable, Hashable{
    let chefId: String
    let name: String
    let email: String
    let phone: String
    let avatar: String
    let rating: Double
    let totalRatings: Double
    let recipesList: [RecipeModel]? = nil
    
    enum CodingKeys: String, CodingKey {
        case chefId = "chef_id"
        case name
        case email
        case phone
        case avatar
        case rating
        case totalRatings = "total_ratings"
        case recipesList = "recipes_list"
    }
}
