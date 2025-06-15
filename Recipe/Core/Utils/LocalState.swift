//
//  LocalState.swift
//  Recipe
//
//  Created by Hummingbird on 15/06/2025.
//

import Foundation
import SwiftUI

enum Keys: String{
    case isFirstTimeUsingApp
    case fontPrefix
    case theme
}

public class LocalState {
    @AppStorage(Keys.isFirstTimeUsingApp.rawValue) static var isFirstLaunch: Bool = true
    @AppStorage(Keys.fontPrefix.rawValue) static var selectedFontPrefix: String = "Poppins"
    //@AppStorage(Keys.theme.rawValue) static var theme: AppTheme = AppTheme.system
    
    /*
    static var colorScheme: ColorScheme?{
        switch theme{
            case .system:
            print("DEBUG: theme is \(theme)")
                return nil
            case .dark:
            print("DEBUG: theme is \(theme)")
                return .dark
            case .light:
            print("DEBUG: theme is \(theme)")
                return .light
        }
    }
    */

}
