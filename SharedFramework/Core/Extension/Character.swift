//
//  Character.swift
//  Recipe
//
//  Created by RAFIKI on 21/05/2026.
//

import Foundation

extension Character {
    var isEmoji: Bool {
        return unicodeScalars.contains { scalar in
            switch scalar.value {
            case 0x1F600...0x1F64F,
                0x1F300...0x1F5FF,
                0x1F680...0x1F6FF,
                0x1F700...0x1F77F,
                0x1F780...0x1F7FF,
                0x1F800...0x1F8FF,
                0x1F900...0x1F9FF,
                0x1FA00...0x1FA6F,
                0x1FA70...0x1FAFF,
                0x2600...0x26FF,
                0x2700...0x27BF,
                0xFE00...0xFE0F,
                0x1F1E6...0x1F1FF:
                return true
            default:
                return false
            }
        }
    }
}
