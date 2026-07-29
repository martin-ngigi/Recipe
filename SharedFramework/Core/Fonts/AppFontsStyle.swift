/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

//
//  AppFontsStyle.swift
//  Recipe
//
//  Created by RAFIKI on 29/07/2026.
//

import Foundation
import SwiftUI
import UIKit

extension Font {
    static func app(_ weight: AppFonts, relativeTo textStyle: Font.TextStyle) -> Font {
        let size = UIFont.preferredFont(forTextStyle: textStyle.uiKit).pointSize
        return .custom(weight.font, size: size, relativeTo: textStyle)
    }
}

extension Font.TextStyle {
    var uiKit: UIFont.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .body: return .body
        case .callout: return .callout
        case .subheadline: return .subheadline
        case .footnote: return .footnote
        case .caption: return .caption1
        case .caption2: return .caption2
        @unknown default: return .body
        }
    }
}

extension Font {
    static var appLargeTitle: Font { .app(.bold, relativeTo: .largeTitle) }
    static var appTitle: Font { .app(.bold, relativeTo: .title) }
    static var appTitle2: Font { .app(.semiBold, relativeTo: .title2) }
    static var appTitle3: Font { .app(.semiBold, relativeTo: .title3) }
    static var appHeadline: Font { .app(.semiBold, relativeTo: .headline) }
    static var appBody: Font { .app(.regular, relativeTo: .body) }
    static var appCallout: Font { .app(.regular, relativeTo: .callout) }
    static var appSubheadline: Font { .app(.medium, relativeTo: .subheadline) }
    static var appFootnote: Font { .app(.regular, relativeTo: .footnote) }
    static var appCaption: Font { .app(.regular, relativeTo: .caption) }
    static var appCaption2: Font { .app(.medium, relativeTo: .caption2) }
}
