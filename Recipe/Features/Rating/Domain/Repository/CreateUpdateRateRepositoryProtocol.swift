//
//  CreateUpdateRateRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

protocol CreateUpdateRateRepositoryProtocol {
    func createUpdateRate(createRateRequestModel: CreateRateRequestModel) async -> Result<CreateRateResponseModel, APIError>
}
