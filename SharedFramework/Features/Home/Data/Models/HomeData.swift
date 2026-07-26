//
//  HomeData.swift
//  Recipe
//
//  Created by Hummingbird on 09/07/2025.
//

import Foundation
import SwiftData

@Model
class HomeDataSwiftData {
    var justForYou: [RecipeSwiftData]
    var trendingRecipes: [RecipeSwiftData]
    var popularChefs: [UserSwiftData]

    init(justForYou: [RecipeSwiftData], trendingRecipes: [RecipeSwiftData], popularChefs: [UserSwiftData]) {
        self.justForYou = justForYou
        self.trendingRecipes = trendingRecipes
        self.popularChefs = popularChefs
    }

    convenience init(model: HomeData) {
        let justForYouSwiftData = model.justForYou.map { RecipeSwiftData(model: $0) }
        let trendingRecipesSwiftData = model.trendingRecipes.map { RecipeSwiftData(model: $0) }
        let popularChefsSwiftData = model.popularChefs.map { UserSwiftData(model: $0) }

        self.init(
            justForYou: justForYouSwiftData,
            trendingRecipes: trendingRecipesSwiftData,
            popularChefs: popularChefsSwiftData
        )
    }

    deinit {}
}

struct HomeData: Codable {

    enum CodingKeys: String, CodingKey {
        case justForYou = "just_for_you"
        case trendingRecipes = "trending_recipes"
        case popularChefs = "popular_chefs"
    }

    let justForYou: [RecipeModel]
    let trendingRecipes: [RecipeModel]
    let popularChefs: [UserModel]

    init(swiftData: HomeDataSwiftData) {
        let justForYouModel = swiftData.justForYou.map { RecipeModel(swiftData: $0) }
        let trendingRecipesModel = swiftData.trendingRecipes.map { RecipeModel(swiftData: $0) }
        let popularChefsModel = swiftData.popularChefs.map { UserModel(swiftData: $0) }

        self.justForYou = justForYouModel
        self.trendingRecipes = trendingRecipesModel
        self.popularChefs = popularChefsModel
    }
}
