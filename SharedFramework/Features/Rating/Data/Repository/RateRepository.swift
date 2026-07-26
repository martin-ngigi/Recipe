//
//  RateRepository.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

struct RateRepository: CreateUpdateRateRepositoryProtocol {
    static let shared = RateRepository()
    var datasource = RatingDataSource()

    func createUpdateRate(
        createRateRequestModel: CreateRateRequestModel
    ) async -> Result<CreateRateResponseModel, APIError> {
        return await datasource.createUpdateRate(createRateRequestModel: createRateRequestModel)
    }
}
