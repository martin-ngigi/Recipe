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
