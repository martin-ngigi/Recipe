//
//  Router.swift
//  Recipe
//
//  Created by Hummingbird on 04/05/2025.
//

import Foundation

import SwiftUI

/*
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
*/

class Router: ObservableObject {
    // Published property to be used with SwiftUI's NavigationStack
    @Published var path = NavigationPath()
    
    // Internal mirror stack to allow easier route manipulation and tracking
    private var routeStack: [Route] = []

    /// Pushes a new route onto the navigation stack
    /// - Parameter route: The route to navigate to
    func push(_ route: Route) {
        path.append(route)
        routeStack.append(route)
    }

    /// Pops the last route from the stack (navigates back by one screen)
    func pop() {
        if !routeStack.isEmpty {
            path.removeLast()
            routeStack.removeLast()
        }
    }

    /// Pops all routes and returns to the root screen
    func popToRoot() {
        path = NavigationPath()
        routeStack.removeAll()
    }

    /// Replaces the current navigation stack with a single new route
    /// Useful when you don’t want the user to go back to previous screens
    /// - Parameter route: The new route to display
    func replace(with route: Route) {
        path = NavigationPath()
        routeStack = [route]
        path.append(route)
    }

    /// Replaces the current navigation stack with a list of routes
    /// Useful for building up a multi-step screen history programmatically
    /// - Parameter routes: A list of routes to push in order
    /// Replace the entire stack with multiple routes (e.g., after login: [.dashboard, .profile])
    func replaceStack(with routes: [Route]) {
        path = NavigationPath()
        routeStack = routes
        for route in routes {
            path.append(route)
        }
    }

    /// Pops routes from the stack until the first occurrence of a given route type is found
    /// Example: `popTo(HomeRoute.self)` will pop all routes above the first `HomeRoute`
    /// - Parameter routeType: The type of route to pop to
    func popTo(_ routeType: Route.Type) {
        while let last = routeStack.last, type(of: last) != routeType {
            path.removeLast()
            routeStack.removeLast()
        }
    }

    /// Checks whether a specific route is currently in the navigation stack
    /// - Parameter route: The route to check for
    /// - Returns: `true` if the route exists in the stack
    func contains(_ route: Route) -> Bool {
        return routeStack.contains(route)
    }

    /// Removes a specific route from the navigation stack if it exists
    /// After removal, it rebuilds the navigation path
    /// - Parameter route: The route to remove
    func remove(_ route: Route) {
        guard let index = routeStack.firstIndex(of: route) else { return }
        routeStack.remove(at: index)
        path = NavigationPath()
        for route in routeStack {
            path.append(route)
        }
    }

    /// Pops the current route and immediately pushes a new one
    /// Useful when replacing the current screen with a new one
    /// - Parameter route: The new route to navigate to
    func popThenPush(_ route: Route) {
        pop()
        push(route)
    }

    /// Clears the entire navigation stack
    /// Effectively resets the navigation to its initial state
    func reset() {
        path = NavigationPath()
        routeStack.removeAll()
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
