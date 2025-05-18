//
//  ThemesViewModel.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import Foundation
import SwiftUI

class ThemesViewModel: ObservableObject{
    @Published var selectedFontPrefix = "Poppins"
    
    @AppStorage("selectedTheme") var selectedTheme: AppTheme = AppTheme.system
    
    //
    var colorScheme: ColorScheme?{
        switch selectedTheme{
            case .system:
                return nil
            case .dark:
                return .dark
            case .light:
                return .light
        }
    }
}
