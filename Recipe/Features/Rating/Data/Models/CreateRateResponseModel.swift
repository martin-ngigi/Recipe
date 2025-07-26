//
//  CreateRateResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

// MARK: - CreateRateResponseModel
struct CreateRateResponseModel: Codable {
    let message: String
    let data: RateResponseModel
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message, data
        case statusCode = "status_code"
    }
}

// MARK: - RateResponseModel
struct RateResponseModel: Codable {
    let totalRate: TotalRateModel
    let ratings: [AllRatingModel]

    enum CodingKeys: String, CodingKey {
        case ratings
        case totalRate = "total_rate"
    }
}
