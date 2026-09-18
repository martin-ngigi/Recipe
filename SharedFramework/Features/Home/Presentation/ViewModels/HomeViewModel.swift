/*
* Created by Martin Wainaina on 25/08/2026
*
* Feel free to contribute.
*/

//
//  HomeViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation
import os
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var fetchHomeDataState = FetchState.good
    @Published var searchState = FetchState.good
    var homeUseCases = HomeUseCases(
        fetchHomeDataRepository: HomeRepository.shared,
        searchAllRepository: HomeRepository.shared
    )
    @Published var justForYouList: [RecipeModel] = []
    @Published var trendingRecipesList: [RecipeModel] = []
    @Published var popularChefsList: [UserModel] = []
    @Published var isShowInbuiltAlert = false
    @Published var isShowSearchResults = false
    @Published var inbuiltAlert: InbuiltAlert?
    @Published var searchText: String = ""
    @Published var searchRecipes: [RecipeModel] = []
    @Published var searchChefs: [UserModel] = []

    @Published var recipePage: Int = 0
    @Published var chefPage: Int = 0
    @Published var currentIndex: Int = 0
    @Published var searchField = ""

    func fetchHomeData(
        onSuccess: (HomeResponseModel) -> Void,
        onFailure: (String) -> Void
    ) async {
        
        let isListEmpty = justForYouList.isEmpty || trendingRecipesList.isEmpty || popularChefsList.isEmpty
        
        if !isListEmpty{
            return
        }
        
        fetchHomeDataState = .isLoading
        let results = await homeUseCases.executeFetchHomeData()
        switch results {
        case .success(let response):
            fetchHomeDataState = .good
            justForYouList = response.data.justForYou
            trendingRecipesList = response.data.trendingRecipes
            popularChefsList = response.data.popularChefs
            onSuccess(response)
        case .failure(let error):
            os.Logger().debug("DEBUG: fetchHomeData error \(error.description)")
            fetchHomeDataState = .error(error.description)
            onFailure(error.description)
        }
    }

    func updateIsShowInbuiltAlert(value: Bool) {
        isShowInbuiltAlert = value
    }

    func updateInbuiltAlert(value: InbuiltAlert) {
        inbuiltAlert = value
    }

    func searchAll(
        searchText: String,
        onSuccess: (SearchResponseModel) -> Void,
        onFailure: (String) -> Void
    ) async {
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

    deinit {}
}
