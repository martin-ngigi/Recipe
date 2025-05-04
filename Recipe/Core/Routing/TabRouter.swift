//
//  TabRouter.swift
//  Recipe
//
//  Created by Hummingbird on 04/05/2025.
//

import Foundation

import SwiftUI

class TabRouter: ObservableObject{
    @Published var selectedTab: TabItemEntity = .home
    
    var homeRouter = Router()
    var favouritesRouter = Router()
    var settingsRouter = Router()
    var profileRouter = Router()
    
    func router(for tab: TabItemEntity) -> Router{
        switch tab {
        case .home:
            return homeRouter
        case .favoutites:
            return favouritesRouter
        case .profile:
            return profileRouter
        case .settings:
            return settingsRouter
        }
    }

}

@ViewBuilder
func viewForRoute(_ route: Route, router: Router) -> some View{
    switch route {
/*
 case landing
 
 case home
 case favourites
 case profile
 case settings
 
 case login
 case register
 case recipedetails(recipe: String)
 */
    case .landing:
        LandingView()
        
    case .login:
        LoginView()
            .environmentObject(router) // inject router
        
    case .register:
        RegisterView()
            .environmentObject(router) // inject router

    case .home:
        HomeView()
            //.environmentObject(TabRouter()) // optional if HomeView uses tabRouter, else remove

    case .favourites:
        FavouriteItemView()
            //.environmentObject(TabRouter()) // optional if HomeView uses tabRouter, else remove
 
    case .profile:
        ProfileView()
            //.environmentObject(TabRouter()) // optional if HomeView uses tabRouter, else remove

    case .settings:
        SettingsScreen()
            //.environmentObject(TabRouter()) // optional if HomeView uses tabRouter, else remove
        
    case .recipedetails(let recipe):
        RecipeDetailsView(recipe: recipe)
            .environmentObject(router) // inject router
    }
}
