/*
* Created by Martin Wainaina on 19/08/2026
*
* Feel free to contribute.
*/

//
//  SettingsViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 15/06/2025.
//

import Foundation
import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published var toast: Toast?
    @Published var isNotificationsEnabled = false
    @Published var textSize = 5.0

    func updateToast(value: Toast?) {
        toast = value
    }

    func updateIsNotificationsEnabled(value: Bool) {
        isNotificationsEnabled = value
    }

    deinit {}
}
