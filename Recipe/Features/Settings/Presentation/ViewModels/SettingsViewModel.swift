//
//  SettingsViewModel.swift
//  Recipe
//
//  Created by Hummingbird on 15/06/2025.
//

import Foundation
import SwiftUI



class SettingsViewModel: ObservableObject{
    @Published var toast: Toast?
    @Published var isNotificationsEnabled = false
    
    func updateToast(value: Toast?) {
        toast = value
    }
    
    func updateIsNotificationsEnabled(value: Bool) {
        isNotificationsEnabled = value
    }
}
