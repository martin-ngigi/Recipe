//
//  HomeResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct HomeResponseModel: Codable{
    let message: String
    let statusCode: Int
    let data: HomeData
    
    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case data
    }
}

struct HomeData: Codable{
    let justForYou: [RecipeModel]
    let trendingRecipes: [RecipeModel]
    let popularChefs: [ChefModel]
    
    enum CodingKeys: String, CodingKey {
        case justForYou = "just_for_you"
        case trendingRecipes = "trending_recipes"
        case popularChefs = "popular_chefs"
    }
}

extension HomeResponseModel {
    static var sampleData =  HomeReponseDummyData.dataModel
}
