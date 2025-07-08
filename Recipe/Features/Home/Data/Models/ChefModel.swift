//
//  ChefModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct ChefModel: Codable, Hashable{
    let openId: String
    let name: String
    let email: String
    let phone: String?
    let avatar: String
    var recipesList: [RecipeModel]? = nil
    var allRates: [AllRatingModel]? = nil
    var rate: TotalRateModel? = nil
    
    enum CodingKeys: String, CodingKey {
        case openId = "open_id"
        case name
        case email
        case phone
        case avatar
        case recipesList = "recipes_list"
        case allRates = "all_rates"
        case rate = "rate"
    }
}

extension ChefModel {
    static var dummyChefResoinse = ChefDummyData.dataModel
}
