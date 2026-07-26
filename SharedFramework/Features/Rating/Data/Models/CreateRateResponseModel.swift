//
//  CreateRateResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

struct RateResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case ratings
        case totalRate = "total_rate"
    }

    let totalRate: TotalRateModel
    let ratings: [AllRatingModel]

}

struct CreateRateResponseModel: Codable {

    enum CodingKeys: String, CodingKey {
        case message, data
        case statusCode = "status_code"
    }

    let message: String
    let data: RateResponseModel
    let statusCode: Int

}
