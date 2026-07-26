//
//  ChefUseCases.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation

struct ChefUseCases {
    let chefRepository: ChefRepositoryProtocol

    func executeFetchChefById(chefId: String) async -> Result<ChefResponseModel, APIError> {
        return await chefRepository.fetchChefById(chefId: chefId)
    }
}
