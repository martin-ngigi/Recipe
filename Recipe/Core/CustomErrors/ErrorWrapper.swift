//
//  ErrorWrapper.swift
//  Recipe
//
//  Created by Martin on 15/04/2025.
//

import Foundation

struct ErrorWrapper: Identifiable{
    let id = UUID()
    let error: Error
    let guidance: String
}
