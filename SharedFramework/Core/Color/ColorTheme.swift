/*
* Created by Martin Wainaina on 17/09/2026
*
* Feel free to contribute.
*/

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
    
    let primaryColor = Color("CoralColor")
    let secondaryColor = Color("TealGreenColor")
    
    let successColor = Color("FreshGreenColor")
    let warningColor = Color("MustardColor")
    let errorColor = Color("RedColor")
    
    let backgroundColor = Color("BackgroundColor")
    let surfaceAndCardColor = Color("SurfaceAndCardColor")
    
    let primaryTextColor = Color("PrimaryTextColor")
    let secondaryTextColor = Color("SecondaryTextColor")
}

extension Color {
    static var theme = ColorTheme()
}
