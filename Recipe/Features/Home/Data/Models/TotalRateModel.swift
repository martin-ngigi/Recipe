//
//  TotalRateModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation
struct TotalRateModel: Codable, Hashable {
    let rateID, openID: String
    let rating: Double
    let totalRatings: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case rateID = "rate_id"
        case openID = "open_id"
        case rating
        case totalRatings = "total_ratings"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
