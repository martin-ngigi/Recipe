//
//  HomeUseCases.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct HomeUseCases {
    let fetchHomeDataRepository: FetchHomeDataRepositoryProtocol
    
    init(fetchHomeDataRepository: FetchHomeDataRepositoryProtocol) {
        self.fetchHomeDataRepository = fetchHomeDataRepository
    }
    
    func executeFetchHomeData() async -> Result<HomeResponseModel, APIError> {
        return await fetchHomeDataRepository.fetchHomeData()
    }
}
