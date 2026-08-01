/*
* Created by Martin Wainaina on 01/08/2026
*
* Feel free to contribute.
*/

//
//  SwipeBackDisabled.swift
//  Recipe
//
//  Created by RAFIKI on 01/08/2026.
//

import Foundation
import SwiftUI

struct SwipeBackDisabled: ViewModifier {
    let disabled: Bool

    func body(content: Content) -> some View {
        content
            .onAppear {
                if disabled {
                    SwipeBackLock.shared.isEnabled = false
                }
            }
            .onDisappear {
                SwipeBackLock.shared.isEnabled = true
            }
    }
}
