//
//  Route.swift
//  Recipe
//
//  Created by Hummingbird on 04/05/2025.
//

import Foundation

enum Route: Hashable {
    case landing
    
    case login
    case register
    
    case dashboard
    case home
    case favourites
    case profile
    case settings
    

    case recipedetails(recipe: RecipeModel)
    case chefdetails(chef: UserModel)
    case trendingRecipes(list: [RecipeModel])
    case popularChefs(list: [UserModel])
}
