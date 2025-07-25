//
//  HomeRepository.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct HomeRepository: FetchHomeDataRepositoryProtocol, SearchAllRepositoryProtocol{
    
    var datasource = HomeRemoteDataSource()
    static let shared = HomeRepository()
    
    func fetchHomeData() async -> Result<HomeResponseModel, APIError> {
        return await datasource.fetchHomeData()
    }
    
    func searchAll(searchTerm: String) async -> Result<SearchResponseModel, APIError> {
        return await datasource.searchAll(searchTerm: searchTerm)
    }
}
