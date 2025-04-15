//
//  ShowErrorEnvironmentKey.swift
//  Recipe
//
//  Created by Martin on 15/04/2025.
//

import Foundation
import SwiftUI

struct ShowErrorAction {
    typealias Action = (Error, String) -> ()
    var action: Action
    func callAsFunction(_ error: Error, _ guidance: String) {
        action(error, guidance)
    }
}

struct ShowErrorEnvironmentKey: EnvironmentKey {
    static var defaultValue: ShowErrorAction = ShowErrorAction{ _, _ in}
}

extension EnvironmentValues {
    var showError: (ShowErrorAction) {
        get { self[ShowErrorEnvironmentKey.self]  }
        set { self[ShowErrorEnvironmentKey.self] = newValue }
    }
}
