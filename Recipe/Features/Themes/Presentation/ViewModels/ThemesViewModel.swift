//
//  ThemesViewModel.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
import SwiftUI///

class ThemesViewModel: ObservableObject{
    @Published var currentTheme: ThemeEntity = .device

    func changeTheme(to theme: ThemeEntity) {
        LocalState.isDarkModeOn = theme == .dark
        currentTheme = theme
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = theme.userInterfaceStyle
        print("Debug: isDarkModeOn \(LocalState.isDarkModeOn)")
    }
    
    func setAppTheme() {
        print("Debug: isDarkModeOn \(LocalState.isDarkModeOn)")
        currentTheme = ThemeEntity(isDarkModeOn: LocalState.isDarkModeOn)
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = currentTheme.userInterfaceStyle
        print("DEBUG: currentTheme \(currentTheme.themName)")
    }
}
