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
        LoginView()
            .navigationBarBackButtonHidden()
        
    case .register:
        RegisterView()
            .navigationBarBackButtonHidden()

    case .home:
        HomeView()

    case .favourites:
        FavouritesListView()
 
    case .profile:
        ProfileView()

    case .settings:
        SettingsScreen()
        
    case .recipedetails(let recipe):
        RecipeDetailsView(recipe: recipe)
        
    case .chefdetails(let chef):
        ChefDetailsView(chef: chef)
    }
}
