/*
* Created by Martin Wainaina on 24/09/2026
*
* Feel free to contribute.
*/

//
//  HomeMockRepository.swift
//  Recipe
//
//  Created by RAFIKI on 24/09/2026.
//

import Foundation
import os

struct HomeMockRepository: FetchHomeDataRepositoryProtocol, SearchAllRepositoryProtocol {
    
    static let shared = HomeMockRepository()
    
    func fetchHomeData() async -> Result<HomeResponseModel, APIError> {
        guard let data = HomeMockData().response.data(using: .utf8) else {
            return .failure(.custom("Failed to encode home data"))
        }
        
        do{
            let decoder = JSONDecoder()
            let model = try decoder.decode(HomeResponseModel.self, from: data)
            return .success(model)
        }
        catch{
            Logger().debug("DEBUG: Error fetchHomeData \(error.localizedDescription)")
            return .failure(.custom(error.localizedDescription))
        }
    }
    
    var sampleHomeResponse: HomeResponseModel? {
        return HomeMockData().response.decodeJSON(to: HomeResponseModel.self)
    }
    
    func searchAll(searchTerm: String) async -> Result<SearchResponseModel, APIError> {
        return .failure(.custom("Coming soon."))
    }
}
