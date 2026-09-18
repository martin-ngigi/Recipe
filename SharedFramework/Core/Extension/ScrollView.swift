/*
* Created by Martin Wainaina on 17/09/2026
*
* Feel free to contribute.
*/

//
//  ScrollView.swift
//  Recipe
//
//  Created by RAFIKI on 17/09/2026.
//

import SwiftUI

extension ScrollView {
    /// A function that returns a view after it applies `FlexibleHeaderScrollViewModifier` to it.
    @MainActor func flexibleHeaderScrollView() -> some View {
        modifier(FlexibleHeaderScrollViewModifier())
    }
}
