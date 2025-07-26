//
//  CreateRateRequestModel.swift
//  Recipe
//
//  Created by Hummingbird on 23/07/2025.
//

import Foundation
struct CreateRateRequestModel: Codable {
    let raterID, rateeID: String
    let rating: Int
    let comment: String

    enum CodingKeys: String, CodingKey {
        case raterID = "rater_id"
        case rateeID = "ratee_id"
        case rating, comment
    }
}
