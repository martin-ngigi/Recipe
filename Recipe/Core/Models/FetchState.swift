//
//  FetchState.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

enum FetchState: Comparable{
    case good
    case isLoading
    case noResults
    case error(String)
}
