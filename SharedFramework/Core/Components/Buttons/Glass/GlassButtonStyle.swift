/*
* Created by Martin Wainaina on 12/08/2026
*
* Feel free to contribute.
*/

//
//  GlassButtonStyle.swift
//  Recipe
//
//  Created by RAFIKI on 04/08/2026.
//

import Foundation

import Foundation
import SwiftUI

@available(iOS 26.0, *)
struct GlassButtonStyle: ViewModifier {
    let isFilled: Bool

    func body(content: Content) -> some View {
        if isFilled {
            content.buttonStyle(.glassProminent)
        }
        else {
            content.buttonStyle(.glass)
        }
    }
}
