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
    let whiteColor = Color("WhiteAppColor")
    let greenAppColor = Color("GreenAppColor")
    let primaryColor = Color("GreenAppColor")
    let grayColor1 = Color("GrayColor1")
}


extension Color {
    static var theme = ColorTheme()    
}
