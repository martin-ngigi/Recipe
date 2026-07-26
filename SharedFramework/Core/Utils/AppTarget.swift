//
//  AppTarget.swift
//  Recipe
//
//  Created by RAFIKI on 26/07/2026.
//

import Foundation

/// Returns current target of the application
/// Add it, navigate to Build Setting > Swift Compiler - Custom
enum AppTarget {
    case USER
    case CHEF

    static var current: AppTarget {
        #if USER
            return .USER
        #elseif CHEF
            return .CHEF
        #else
            return .USER
        #endif
    }

}
