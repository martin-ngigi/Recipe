//
//  TabItemEntity.swift
//  Recipe
//
//  Created by Martin on 24/03/2025.
//

import Foundation
import SwiftUI

enum TabItemEntity: Int, CaseIterable{
    case home = 0
    case favoutites
    case profile
    case settings
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favoutites:
            return "Favouites"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "home"
        case .favoutites:
            return "favourite"
        case .profile:
            return "account"
        case .settings:
            return "settings"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return Color.orange
        case .favoutites:
            return Color.green
        case .profile:
            return Color.blue
        case .settings:
            return Color.cyan
        }
    }
}
