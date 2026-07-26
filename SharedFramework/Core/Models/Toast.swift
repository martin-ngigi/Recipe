//
//  Toast.swift
//  Recipe
//
//  Created by Hummingbird on 28/07/2025.
//

import Foundation

struct Toast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double = 3
    var width: Double = .infinity
}
