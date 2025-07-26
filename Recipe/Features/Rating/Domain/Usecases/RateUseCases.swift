//
//  RateUseCases.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

struct RateUseCases{
    let createUpdateRateRepository: CreateUpdateRateRepositoryProtocol
    
    init(createUpdateRateRepository: CreateUpdateRateRepositoryProtocol) {
        self.createUpdateRateRepository = createUpdateRateRepository
    }
    
    func createUpdateRate(createRateRequestModel: CreateRateRequestModel) async -> Result<CreateRateResponseModel, APIError>{
        return await createUpdateRateRepository.createUpdateRate(createRateRequestModel: createRateRequestModel)
    }
}
