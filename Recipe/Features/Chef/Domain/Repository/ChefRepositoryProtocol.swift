//
//  ChefRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation

protocol ChefRepositoryProtocol {
    func fetchChefById(chefId: String) async -> Result<ChefResponseModel, APIError>
}
