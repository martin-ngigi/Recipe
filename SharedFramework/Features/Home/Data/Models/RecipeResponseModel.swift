//
//  RecipeResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 27/07/2025.
//

import Foundation

struct RecipeResponseModel: Codable {

    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case data
    }

    let message: String
    let statusCode: Int
    let data: [RecipeModel]
}
