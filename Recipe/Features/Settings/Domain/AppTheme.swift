//
//  AppTheme.swift
//  Recipe
//
//  Created by Hummingbird on 18/05/2025.
//

import Foundation

enum AppTheme: String, CaseIterable, Identifiable {
    case system, light, dark
    
    var id: String{ rawValue}
}
