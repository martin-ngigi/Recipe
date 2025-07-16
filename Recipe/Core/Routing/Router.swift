//
//  Router.swift
//  Recipe
//
//  Created by Hummingbird on 04/05/2025.
//

import Foundation

import SwiftUI

class Router: ObservableObject{
    @Published var path = NavigationPath()
    
    func push(_ route: Route){
        path.append(route)
    }
    
    func pop(){
        if !path.isEmpty{
            path.removeLast()
        }
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
}


@ViewBuilder
func viewForRoute(_ route: Route, router: Router) -> some View{
    switch route {
        
    case .landing:
        LandingView()
            .navigationBarBackButtonHidden()
        
    case .dashboard:
        DashboardView()
           // .navigationBarBackButtonHidden() //MARK: Temporal fix
        
    case .login:
        LoginView(
            onLoginSuccess: {},
            onLoginFailure: {_ in}
        )
            .navigationBarBackButtonHidden()
        
    case .register:
        RegisterView()
            .navigationBarBackButtonHidden()

    case .home:
        HomeView()

    case .favourites:
        FavouritesListView()
 
    case .profile:
        ProfileView(
            onLogoutSuccess: {
                
            },
            onLogoutFailed: {error in
                
            }
        )

    case .settings:
        SettingsScreen()
        
    case .recipedetails(let recipe):
        RecipeDetailsView(recipe: recipe)
            .navigationBarBackButtonHidden()

    case .chefdetails(let chef):
        ChefDetailsView(chef: chef)
        
    case .trendingRecipes(let list):
        TrendingRecipesView(list: list)
        
    case .popularChefs(let list):
        AllChefsView(list: list)
    }
}
