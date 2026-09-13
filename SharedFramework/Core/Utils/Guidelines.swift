/*
* Created by Martin Wainaina on 13/09/2026
*
* Feel free to contribute.
*/

//
//  Guidelines.swift
//  Recipe
//
//  Created by RAFIKI on 13/09/2026.
//

import Foundation
import SwiftUI

enum Guidelines {

    // Typography
    static let fontSize: CGFloat = 17
    static let placeholderFontSize: CGFloat = 17
    static let labelFontSize: CGFloat = 13
    static let errorFontSize: CGFloat = 12
    static let fontFamily: String = AppFonts.light.font

    // Sizing
    static let minHeight: CGFloat = 44
    static let minWidth: CGFloat = 44
    static let preferredHeight: CGFloat = 50
    static let maxWidth: CGFloat = .infinity
    static let minTappableLength: CGFloat = 44

    // Spacing & Layout
    static let cornerRadius: CGFloat = 24
    static let borderWidth: CGFloat = 1
    static let focusedBorderWidth: CGFloat = 1.5
    static let horizontalPadding: CGFloat = 16
    static let horizontalPaddingInner: CGFloat = 8
    static let verticalPadding: CGFloat = 16
    static let labelSpacing: CGFloat = 4
    static let errorSpacing: CGFloat = 4
    static let fieldGroupSpacing: CGFloat = 16
    static let iconSize: CGFloat = 20
    static let iconPadding: CGFloat = 12

    // Colors
    static let backgroundColor = Color(.secondarySystemBackground)
    static let focusedBackgroundColor = Color(.systemBackground)
    static let disabledBackgroundColor = Color(.tertiarySystemBackground)
    static let borderColor = Color(.separator)
    static let focusedBorderColor = Color(.systemBlue)
    static let errorBorderColor = Color(.systemRed)
    static let textColor = Color(.label)
    static let placeholderColor = Color(.placeholderText)
    static let labelColor = Color(.secondaryLabel)
    static let errorColor = Color(.systemRed)
    static let disabledTextColor = Color(.tertiaryLabel)
    static let cursorColor = Color(.systemBlue)

    // Animation
    static let focusAnimationDuration: TimeInterval = 0.2
    static let errorShakeDuration: TimeInterval = 0.4
    static let errorShakeOffset: CGFloat = 6

    // Accessibility
    static let minimumContrastRatio: CGFloat = 4.5
    static let accessibilityMinHeight: CGFloat = 44
    static let clearButtonSize: CGFloat = 44 
}
