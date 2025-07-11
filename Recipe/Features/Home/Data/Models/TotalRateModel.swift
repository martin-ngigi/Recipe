//
//  TotalRateModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//
import SwiftData

import Foundation
struct TotalRateModel: Codable, Hashable {
    let rateID, openID: String
    let rating: Double
    let totalRatings: Int
    let createdAt, updatedAt: String
    var ratingFormatted: String{
        return "\(rating)".to2Decimals()
    }

    enum CodingKeys: String, CodingKey {
        case rateID = "rate_id"
        case openID = "open_id"
        case rating
        case totalRatings = "total_ratings"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension TotalRateModel {
    init(swiftData: TotalRateSwiftData) {
        self.rateID = swiftData.rateID
        self.openID = swiftData.openID
        self.rating = swiftData.rating
        self.totalRatings = swiftData.totalRatings
        self.createdAt = swiftData.createdAt
        self.updatedAt = swiftData.updatedAt
    }
}

@Model
class TotalRateSwiftData {
    var rateID: String
    var openID: String
    var rating: Double
    var totalRatings: Int
    var createdAt: String
    var updatedAt: String

    init(rateID: String, openID: String, rating: Double, totalRatings: Int, createdAt: String, updatedAt: String) {
        self.rateID = rateID
        self.openID = openID
        self.rating = rating
        self.totalRatings = totalRatings
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension TotalRateSwiftData {
    convenience init(model: TotalRateModel) {
        self.init(
            rateID: model.rateID,
            openID: model.openID,
            rating: model.rating,
            totalRatings: model.totalRatings,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt
        )
    }
}
