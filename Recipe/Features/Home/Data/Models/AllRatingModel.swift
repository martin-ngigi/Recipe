//
//  AllRatingModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation

struct AllRatingModel: Codable, Hashable {
    let rateID, rateeID, raterID: String
    let rating: Double
    let comment: String
    let rater: UserModel

    enum CodingKeys: String, CodingKey {
        case rateID = "rate_id"
        case rateeID = "ratee_id"
        case raterID = "rater_id"
        case rating, comment, rater
    }
}
