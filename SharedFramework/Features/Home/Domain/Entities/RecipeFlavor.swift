//
//  RecipeFlavor.swift
//  Recipe
//
//  Created by RAFIKI on 28/09/2026.
//

import Foundation

import SwiftUI

enum RecipeFlavor: String, CaseIterable, Identifiable {
    case sweet = "Sweet"
    case savory = "Savory"
    case spicy = "Spicy"
    case tangy = "Tangy"
    case smoky = "Smoky"
    case creamy = "Creamy"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .sweet: "birthday.cake"
        case .savory: "fork.knife"
        case .spicy: "flame"
        case .tangy: "citrus"
        case .smoky: "aqi.medium"
        case .creamy: "cup.and.saucer"
        }
    }

    var subtitle: String {
        switch self {
        case .sweet: "Sweet treats"
        case .savory: "Rich & hearty"
        case .spicy: "Bold & hot"
        case .tangy: "Fresh & zesty"
        case .smoky: "Deep & rich"
        case .creamy: "Smooth & rich"
        }
    }

    var color: Color {
        switch self {
        case .sweet: .orange
        case .savory: .brown
        case .spicy: .red
        case .tangy: .green
        case .smoky: .gray
        case .creamy: .purple
        }
    }
}
