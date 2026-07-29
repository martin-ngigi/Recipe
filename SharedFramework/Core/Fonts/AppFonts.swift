/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

//
//  AppFonts.swift
//  Recipe
//
//  Created by RAFIKI on 29/07/2026.
//

import Foundation

enum AppFonts {
    case ultraLight
    case ultraLightItalic
    case thin
    case thinItalic
    case light
    case lightItalic
    case regular
    case regularItalic
    case medium
    case semiBold
    case semiBoldItalic
    case bold
    case boldItalic
    case extraBold
    case extraBoldItalic
    case heavy
    case heavyItalic
    case black
    case blackItalic
    
    var font: String {
        switch self {
        case .ultraLight:
            return "Poppins-UltraLight" //
        case .ultraLightItalic:
            return "Poppins-UltraLightItalic"//
        case .thin:
            return "Poppins-Thin"
        case .thinItalic:
            return "Poppins-ThinItalic"
        case .light:
            return "Poppins-Light"
        case .lightItalic:
            return "Poppins-LightItalic"
        case .regular:
            return "Poppins-Regular"
        case .regularItalic:
            return "Poppins-RegularItalic"//
        case .medium:
            return "Poppins-Medium"
        case .semiBold:
            return "Poppins-SemiBold"
        case .semiBoldItalic:
            return "Poppins-SemiBoldItalic"
        case .bold:
            return "Poppins-Bold"
        case .boldItalic:
            return "Poppins-BoldItalic"
        case .extraBold:
            return "Poppins-ExtraBold"
        case .extraBoldItalic:
            return "Poppins-ExtraBoldItalic"
        case .heavy:
            return "Poppins-Heavy"//
        case .heavyItalic:
            return "Poppins-HeavyItalic"//
        case .black:
            return "Poppins-Black"
        case .blackItalic:
            return "Poppins-BlackItalic"
        }
    }
}
