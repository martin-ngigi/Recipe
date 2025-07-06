//
//  ChefViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation

@MainActor
class ChefViewModel: ObservableObject {
    @Published var fetchChefByIDState = FetchState.good
    var chefUsesCases = ChefUseCases(chefRepository: ChefRepository.shared)
    
    func fetchChefByID(
        chefId: String,
        onSuccess: (ChefModel) -> Void,
        onFailure: (String) -> Void
    ) async {
        fetchChefByIDState = .isLoading
        
        let results = await chefUsesCases.executeFetchChefById(chefId: chefId)
        switch results {
        case .success(let response):
            fetchChefByIDState = .good
            onSuccess(response.data)
            print("DEBUG: fetched chef: \(response.data.name), recipes count \(response.data.recipesList), rating \(response.data.allRates?.count ?? 100)" )
        case .failure(let error):
            fetchChefByIDState = .error(error.description)
            print("DEBUG: fetched failed chef: \(error.description)" )
            onFailure(error.localizedDescription)
        }
    }
}
