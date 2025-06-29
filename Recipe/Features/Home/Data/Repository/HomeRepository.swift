//
//  HomeRepository.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct HomeRepository: FetchHomeDataRepositoryProtocol{
    var datasource = HomeRemoteDataSource()
    static let shared = HomeRepository()
    
    func fetchHomeData() async -> Result<HomeResponseModel, APIError> {
        return await datasource.fetchHomeData()
    }
}
