//
//  ChefRepository.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation
struct ChefRepository: ChefRepositoryProtocol{
    
    static let shared = ChefRepository()
    let chefRemoteDataSource = ChefRemoteDataSource()
    
    func fetchChefById(chefId: String) async -> Result<ChefResponseModel, APIError> {
        return await chefRemoteDataSource.fetchChefById(chefId: chefId)
    }
    
}
