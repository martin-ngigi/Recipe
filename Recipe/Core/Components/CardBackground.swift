//
//  CardBackground.swift
//  Recipe
//
//  Created by RAFIKI on 20/05/2026.
//

import SwiftUI

struct CardBackground: ViewModifier {
    var cornerRadius: CGFloat = 18
    var background = Color(UIColor.secondarySystemBackground)
    var shadowColor = Color.black.opacity(0.06)
    var shadowRadius: CGFloat = 20
    var shadowX: CGFloat = 0
    var shadowY: CGFloat = 10

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(background)
                    .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
            )
    }
}
