/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  ConditionalGlassStyle.swift
//  Recipe
//
//  Created by RAFIKI on 20/08/2026.
//

import Foundation
import SwiftUI

struct ConditionalGlassStyle: ViewModifier {
    let isFilled: Bool

    func body(content: Content) -> some View {
        if isFilled {
            content.buttonStyle(.glassProminent)
                .glassEffect(.regular.interactive())

        }
        else {
            content.buttonStyle(.glass)
                .glassEffect(.regular.interactive())
        }
    }
}
