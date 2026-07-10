//
//  DashboardViewModel.swift
//  Recipe
//
//  Created by Martin on 24/03/2025.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var selectedTab = 0

    @Published var isFirstTimeUsingApp = true

    @Published var isDashboardBottomNavigationVisible: Bool = true
    @Published var isKeyboardVisible: Bool = false

    @Published var keyboardWillShowObserver: NSObjectProtocol?
    @Published var keyboardWillHideObserver: NSObjectProtocol?
    @Published var dashboardVisibilityObserver: NSObjectProtocol?

    deinit {}
}
