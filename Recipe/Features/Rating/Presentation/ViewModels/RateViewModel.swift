//
//  RateViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

@MainActor
class RateViewModel: ObservableObject{
    let rateUseCases = RateUseCases(createUpdateRateRepository: RateRepository.shared)
    @Published var createRateState: FetchState = FetchState.good
    
    func createUpdateRate(
        createRateRequestModel: CreateRateRequestModel,
        onSuccess: (CreateRateResponseModel) -> Void,
        onFailure: (String) -> Void
    ) async{
        
        createRateState = .isLoading
        let results = await rateUseCases.createUpdateRate(createRateRequestModel: createRateRequestModel)
        
        switch results {
        case .success(let response):
            createRateState = .good
            onSuccess(response)
            
        case .failure(let error):
            createRateState = .error(error.description)
            onFailure(error.description)
        }
    }
}
