//
//  ThemesViewModel.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
import SwiftUI
import os

class ThemesViewModel: ObservableObject {
    @Published var currentTheme: ThemeEntity = .device

    func changeTheme(to theme: ThemeEntity) {
        LocalState.isDarkModeOn = "\(theme == .dark)"  // "true" or "false"
        currentTheme = theme
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = theme.userInterfaceStyle
        os.Logger().debug("Debug: isDarkModeOn \(LocalState.isDarkModeOn ?? "")")
    }

    func setAppTheme() {
        var isDarkModeOn: Bool
        let savedThemeIsDarkModeOn: String? = LocalState.isDarkModeOn

        if savedThemeIsDarkModeOn == "true" {
            isDarkModeOn = true
        }
        else if savedThemeIsDarkModeOn == "false" {
            isDarkModeOn = false
        }
        else {
            // Fallback to system default
            let systemStyle = UIScreen.main.traitCollection.userInterfaceStyle
            // isDarkModeOn = systemStyle == .dark ? true : false
            isDarkModeOn = true
        }

        currentTheme = ThemeEntity(isDarkModeOn: isDarkModeOn)
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = currentTheme.userInterfaceStyle
        os.Logger().debug("DEBUG: currentTheme \(self.currentTheme.themName)")
    }

    deinit {}
}
