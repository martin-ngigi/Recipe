//
//  HomeViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var fetchHomeDataState: FetchState = FetchState.good
    @Published var searchState: FetchState = FetchState.good
    var homeUseCases = HomeUseCases(
        fetchHomeDataRepository: HomeRepository.shared,
        searchAllRepository: HomeRepository.shared
    )
    @Published var justForYouList: [RecipeModel] = []
    @Published var trendingRecipesList: [RecipeModel] = []
    @Published var popularChefsList: [UserModel] = []
    @Published var isShowInbuiltAlert = false
    @Published var inbuiltAlert: InbuiltAlert?
    @Published var searchText: String = ""
    
    func fetchHomeData(
        onSuccess: (HomeResponseModel) -> Void,
        onFailure: (String) -> Void
    ) async{
        fetchHomeDataState = .isLoading
        let results = await homeUseCases.executeFetchHomeData()
        switch results {
        case .success(let response):
            fetchHomeDataState = .good
            justForYouList = response.data.justForYou
            print("DEBUG: popularChefsList count \(response.data.popularChefs.count)")
            trendingRecipesList = response.data.trendingRecipes
            popularChefsList = response.data.popularChefs
            onSuccess(response)
        case .failure(let error):
            fetchHomeDataState = .error(error.description)
            onFailure(error.description)
        }
    }
    
    func updateIsShowInbuiltAlert(value: Bool){
        isShowInbuiltAlert = value
    }
    
    func updateInbuiltAlert(value: InbuiltAlert){
        inbuiltAlert = value
    }
    
    func searchAll(
        searchText: String,
        onSuccess: (SearchResponseModel) -> Void,
        onFailure: (String) -> Void
    ) async{
        searchState = .isLoading
        let results = await homeUseCases.executeSearchAll(searchTerm: searchText)
        switch results {
        case .success(let response):
            searchState = .good
            onSuccess(response)
        case .failure(let error):
            searchState = .error(error.description)
            onFailure(error.description)
        }
    }
}
