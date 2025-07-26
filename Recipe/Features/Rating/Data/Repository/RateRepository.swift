//
//  RateRepository.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

struct RateRepository: CreateUpdateRateRepositoryProtocol{
    var datasource = RatingDataSource()
    static let shared = RateRepository()
    
    func createUpdateRate(createRateRequestModel: CreateRateRequestModel) async -> Result<CreateRateResponseModel, APIError> {
        return await datasource.createUpdateRate(createRateRequestModel: createRateRequestModel)
    }
}
