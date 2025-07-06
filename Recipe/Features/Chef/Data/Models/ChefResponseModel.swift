//
//  ChefResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation

struct ChefResponseModel: Codable, Hashable{
    let message: String
    let statusCode: Int
    let data: ChefModel
    
    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case data
    }
}
