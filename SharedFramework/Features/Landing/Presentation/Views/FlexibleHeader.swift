/*
* Created by Martin Wainaina on 17/09/2026
*
* Feel free to contribute.
*/

//
//  FlexibleHeader.swift
//  Recipe
//
//  Created by RAFIKI on 17/09/2026.
//

import Foundation
import SwiftUI


@Observable class FlexibleHeaderGeometry {
    static let shared = FlexibleHeaderGeometry()
    var offset: CGFloat = 0
}

/// A view modifer that stretches content when the containing geometry offset changes.
struct FlexibleHeaderContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        let height = (ModelData.shared.windowSize.height / 2) - FlexibleHeaderGeometry.shared.offset
        content
            .frame(height: height)
            .padding(.bottom, FlexibleHeaderGeometry.shared.offset)
            .offset(y: FlexibleHeaderGeometry.shared.offset)
    }
}

struct FlexibleLandingHeaderContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        let height = (ModelData.shared.windowSize.height * 0.7 ) - FlexibleHeaderGeometry.shared.offset
        content
            .frame(height: height)
            .padding(.bottom, FlexibleHeaderGeometry.shared.offset)
            .offset(y: FlexibleHeaderGeometry.shared.offset)
    }
}

/// A view modifier that tracks scroll view geometry to stretch a view with ``FlexibleHeaderContentModifier``.
struct FlexibleHeaderScrollViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                min(geometry.contentOffset.y + geometry.contentInsets.top, 0)
            } action: { _, offset in
                FlexibleHeaderGeometry.shared.offset = offset
            }
    }
}
