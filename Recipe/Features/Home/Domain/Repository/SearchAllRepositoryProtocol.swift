//
//  SearchAllRepositoryProtocol.swift
//  Recipe
//
//  Created by Hummingbird on 21/07/2025.
//

import Foundation

protocol SearchAllRepositoryProtocol{
    func searchAll(searchTerm: String) async -> Result<SearchResponseModel, APIError>
}
