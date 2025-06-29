//
//  FetchHomeDataRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

protocol FetchHomeDataRepositoryProtocol{
    func fetchHomeData() async -> Result<HomeResponseModel, APIError>
}
