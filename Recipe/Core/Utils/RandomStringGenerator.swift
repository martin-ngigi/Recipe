//
//  RandomStringGenerator.swift
//  Recipe
//
//  Created by Hummingbird on 15/07/2025.
//

import Foundation

class RandomStringGenerator{
    static let shared = RandomStringGenerator()
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
