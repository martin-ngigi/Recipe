/*
* Created by Martin Wainaina on 17/09/2026
*
* Feel free to contribute.
*/

//
//  ModelData.swift
//  Recipe
//
//  Created by RAFIKI on 17/09/2026.
//

import Foundation
internal import CoreGraphics

@Observable @MainActor
class ModelData {
    static let shared = ModelData()
    var windowSize: CGSize = .zero
}
