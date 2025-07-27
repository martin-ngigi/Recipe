//
//  RecipeModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation
import SwiftData

struct RecipeModel: Codable, Hashable{
    let recipeId: String
    let openId: String
    let name: String
    let description: String
    let ingredients: [IngredientModel]
    let image: String
    let instructions: String
    var chef: UserModel? = nil
    var isInFavorite: Bool?
    var inststuctionsList: [String]{
        return instructions.instructionsList
    }
    
    enum CodingKeys: String, CodingKey {
        case openId = "open_id"
        case name
        case description
        case ingredients = "ingredients_list"
        case image
        case instructions
        case recipeId = "recipe_id"
        case chef
    }
}

extension RecipeModel {
    init(swiftData: RecipeSwiftData) {
        // Map ingredients array from IngredientSwiftData to IngredientModel
        //let ingredientsModel = swiftData.ingredients.map { IngredientModel(swiftData: $0) }
        
        // Map optional chef
        //let chefModel = swiftData.chef != nil ? ChefModel(swiftData: swiftData.chef!) : nil
        
        self.recipeId = swiftData.recipeId
        self.openId = swiftData.openId
        self.name = swiftData.name
        self.description = swiftData.description1
        //self.ingredients = ingredientsModel
        self.ingredients = []
        self.image = swiftData.image
        self.instructions = swiftData.instructions
        //self.chef = userModel
        self.chef = nil
        self.isInFavorite = swiftData.isInFavorite
    }
}


@Model
class RecipeSwiftData {
    var recipeId: String
    var openId: String
    var name: String
    var description1: String
    
    //@Relationship(deleteRule: .cascade, inverse: \IngredientSwiftData.recipe)
    //var ingredients = [IngredientSwiftData]()
    
    var image: String
    var instructions: String
    var chef: UserSwiftData?  // Optional nested model
    var isInFavorite: Bool?

    init(
        recipeId: String,
        openId: String,
        name: String,
        description: String,
        //ingredients: [IngredientSwiftData],
        image: String,
        instructions: String,
        //chef: UserSwiftData?,
        isInFavorite: Bool? = nil
    ) {
        self.recipeId = recipeId
        self.openId = openId
        self.name = name
        self.description1 = description
        //self.ingredients = ingredients
        self.image = image
        self.instructions = instructions
        //self.chef = chef
        self.isInFavorite = isInFavorite
    }
}

extension RecipeSwiftData {
    convenience init(model: RecipeModel) {
        // Map ingredients array from IngredientModel to IngredientSwiftData
        //let ingredientsSwiftData = model.ingredients.map { IngredientSwiftData(model: $0) }
        
        // Map optional chef
        let chefSwiftData = model.chef != nil ? UserSwiftData(model: model.chef!) : nil
        
        self.init(
            recipeId: model.recipeId,
            openId: model.openId,
            name: model.name,
            description: model.description,
            //ingredients: ingredientsSwiftData,
            image: model.image,
            instructions: model.instructions,
            //chef: chefSwiftData,
            isInFavorite: model.isInFavorite
        )
    }
}


extension RecipeModel{
    static var dummyList: [RecipeModel] = RecipeResponseDummyData.recipeList
}
