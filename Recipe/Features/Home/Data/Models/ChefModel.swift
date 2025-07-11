//
//  ChefModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation
import SwiftData

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
    init(swiftData: ChefSwiftData) {
        let recipesModel = swiftData.recipesList?.map { RecipeModel(swiftData: $0) }
        let allRatesModel = swiftData.allRates?.map { AllRatingModel(swiftData: $0) }
        let rateModel = swiftData.rate != nil ? TotalRateModel(swiftData: swiftData.rate!) : nil

        self.openId = swiftData.openId
        self.name = swiftData.name
        self.email = swiftData.email
        self.phone = swiftData.phone
        self.avatar = swiftData.avatar
        self.recipesList = recipesModel
        self.allRates = allRatesModel
        self.rate = rateModel
    }
}

@Model
class ChefSwiftData {
    var openId: String
    var name: String
    var email: String
    var phone: String?
    var avatar: String
    var recipesList: [RecipeSwiftData]?  // Optional list of recipes
    var allRates: [AllRatingSwiftData]?  // Optional list of ratings
    var rate: TotalRateSwiftData?        // Optional total rate

    init(
        openId: String,
        name: String,
        email: String,
        phone: String?,
        avatar: String,
        recipesList: [RecipeSwiftData]?,
        allRates: [AllRatingSwiftData]?,
        rate: TotalRateSwiftData?
    ) {
        self.openId = openId
        self.name = name
        self.email = email
        self.phone = phone
        self.avatar = avatar
        self.recipesList = recipesList
        self.allRates = allRates
        self.rate = rate
    }
}

extension ChefSwiftData {
    convenience init(model: ChefModel) {
        let recipesSwiftData = model.recipesList?.map { RecipeSwiftData(model: $0) }
        let allRatesSwiftData = model.allRates?.map { AllRatingSwiftData(model: $0) }
        let rateSwiftData = model.rate != nil ? TotalRateSwiftData(model: model.rate!) : nil

        self.init(
            openId: model.openId,
            name: model.name,
            email: model.email,
            phone: model.phone,
            avatar: model.avatar,
            recipesList: recipesSwiftData,
            allRates: allRatesSwiftData,
            rate: rateSwiftData
        )
    }
}


extension ChefModel {
    static var dummyChefResoinse = ChefDummyData.dataModel
}
