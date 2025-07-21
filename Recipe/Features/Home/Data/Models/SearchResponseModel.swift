//
//  SearchResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 21/07/2025.
//

import Foundation

struct SearchResponseModel: Codable{
    let message: String
    let statusCode: Int
    let recipes: [RecipeModel]
    let chefs: [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case recipes
        case chefs
    }
}
