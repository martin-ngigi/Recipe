//
//  ColorTheme.swift
//  Recipe
//
//  Created by Martin on 12/03/2025.
//

import Foundation
import SwiftUI

struct ColorTheme {
    let blackAndWhite = Color("BlackAndWhite")
    let whiteAndBlack = Color("WhiteAndBlack")
    let greenAppColor = Color("GreenAppColor")
    let primaryColor = Color("GreenAppColor")
}


extension Color {
    static var theme = ColorTheme()    
}
