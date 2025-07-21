//
//  HomeUseCases.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct HomeUseCases {
    let fetchHomeDataRepository: FetchHomeDataRepositoryProtocol
    let searchAllRepository: SearchAllRepositoryProtocol
    
    init(fetchHomeDataRepository: FetchHomeDataRepositoryProtocol, searchAllRepository: SearchAllRepositoryProtocol) {
        self.fetchHomeDataRepository = fetchHomeDataRepository
        self.searchAllRepository = searchAllRepository
    }
    
    func executeFetchHomeData() async -> Result<HomeResponseModel, APIError> {
        return await fetchHomeDataRepository.fetchHomeData()
    }
    
    func executeSearchAll(searchTerm: String) async -> Result<SearchResponseModel, APIError> {
        return await searchAllRepository.searchAll(searchTerm: searchTerm)
    }
}
