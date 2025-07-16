//
//  UserModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation
import SwiftData

struct UserModel: Codable, Hashable {
    let userID, name, email, openID: String
    let avatar, role: String
    let authType: String
    let gender: String?
    let dateOfBirth: String?
    let phone: String?
    let phoneComplete: String?
    let countryCode: String?
    let token, accessToken, createdAt, updatedAt: String?
    
    var recipesList: [RecipeModel]? = nil
    var allRates: [AllRatingModel]? = nil
    var rate: TotalRateModel? = nil
    
    var initials: String {
        let components = name.split(separator: " ")
        let firstInitial = components.first?.prefix(1) ?? ""
        let secondInitial = (components.count > 1 ? components[1].prefix(1) : "")
        return "\(firstInitial)\(secondInitial)".uppercased()
    }

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, email
        case openID = "open_id"
        case authType = "auth_type"
        case avatar, role, gender
        case dateOfBirth = "date_of_birth"
        case phone
        case phoneComplete = "phone_complete"
        case countryCode = "country_code"
        case token
        case accessToken = "access_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
        case recipesList = "recipes_list"
        case allRates = "all_rates"
        case rate = "rate"
    }
    
    init(
        userID: String,
        name: String,
        email: String,
        openID: String,
        authType: String,
        avatar: String,
        role: String,
        gender: String? = nil,
        dateOfBirth: String? = nil,
        phone: String? = nil,
        phoneComplete: String? = nil,
        countryCode: String? = nil,
        token: String? = nil,
        accessToken: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        recipesList: [RecipeModel]? = nil,
        allRates: [AllRatingModel]? = nil,
        rate: TotalRateModel? = nil
    ) {
        self.userID = userID
        self.name = name
        self.email = email
        self.openID = openID
        self.authType = authType
        self.avatar = avatar
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.phoneComplete = phoneComplete
        self.countryCode = countryCode
        self.token = token
        self.accessToken = accessToken
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.recipesList = recipesList
        self.allRates = allRates
        self.rate = rate
    }
}

extension UserModel {
    init(swiftData: UserSwiftData) {
        let recipesModel = swiftData.recipesList?.map { RecipeModel(swiftData: $0) }
        let allRatesModel = swiftData.allRates?.map { AllRatingModel(swiftData: $0) }
        let rateModel = swiftData.rate != nil ? TotalRateModel(swiftData: swiftData.rate!) : nil

        self.userID = swiftData.userID
        self.name = swiftData.name
        self.email = swiftData.email
        self.openID = swiftData.openID
        self.authType = swiftData.authType
        self.avatar = swiftData.avatar
        self.role = swiftData.role
        self.gender = swiftData.gender
        self.dateOfBirth = swiftData.dateOfBirth
        self.phone = swiftData.phone
        self.phoneComplete = swiftData.phoneComplete
        self.countryCode = swiftData.countryCode
        self.token = swiftData.token
        self.accessToken = swiftData.accessToken
        self.createdAt = swiftData.createdAt
        self.updatedAt = swiftData.updatedAt
        
        self.recipesList = recipesModel
        self.allRates = allRatesModel
        self.rate = rateModel
    }
}


@Model
class UserSwiftData {
    var userID: String
    var name: String
    var email: String
    var openID: String
    var authType: String
    var avatar: String
    var role: String
    var gender: String? // Optional
    var dateOfBirth: String?
    var phone: String?
    var phoneComplete: String?
    var countryCode: String? // Optional
    var token: String?
    var accessToken: String?
    var createdAt: String?
    var updatedAt: String?
    
    var recipesList: [RecipeSwiftData]?  // Optional list of recipes
    var allRates: [AllRatingSwiftData]?  // Optional list of ratings
    var rate: TotalRateSwiftData? 

    init(
        userID: String,
        name: String,
        email: String,
        openID: String,
        authType: String,
        avatar: String,
        role: String,
        gender: String? = nil,
        dateOfBirth: String? = nil,
        phone: String? = nil,
        phoneComplete: String? = nil,
        countryCode: String? = nil,
        token: String? = nil,
        accessToken: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        
        recipesList: [RecipeSwiftData]? = [],
        allRates: [AllRatingSwiftData]? = [],
        rate: TotalRateSwiftData? = nil
    ) {
        self.userID = userID
        self.name = name
        self.email = email
        self.openID = openID
        self.authType = authType
        self.avatar = avatar
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.phoneComplete = phoneComplete
        self.countryCode = countryCode
        self.token = token
        self.accessToken = accessToken
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.recipesList = recipesList
        self.allRates = allRates
        self.rate = rate
    }
}

extension UserSwiftData {
    convenience init(model: UserModel) {
        
        let recipesSwiftData = model.recipesList?.map { RecipeSwiftData(model: $0) }
        let allRatesSwiftData = model.allRates?.map { AllRatingSwiftData(model: $0) }
        let rateSwiftData = model.rate != nil ? TotalRateSwiftData(model: model.rate!) : nil

        self.init(
            userID: model.userID,
            name: model.name,
            email: model.email,
            openID: model.openID,
            authType: model.authType,
            avatar: model.avatar,
            role: model.role,
            gender: model.gender,
            dateOfBirth: model.dateOfBirth,
            phone: model.phone,
            phoneComplete: model.phoneComplete,
            countryCode: model.countryCode,
            token: model.token,
            accessToken: model.accessToken,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt,
            
            recipesList: recipesSwiftData,
            allRates: allRatesSwiftData,
            rate: rateSwiftData
        )
    }
}


extension UserModel {
    static var dummyChefResoinse = ChefDummyData.dataModel
}
