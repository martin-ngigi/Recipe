//
//  TabRouter.swift
//  Recipe
//
//  Created by Hummingbird on 04/05/2025.
//

import Foundation

import SwiftUI

class TabRouter: ObservableObject{
    @Published var selectedTab: TabItemEntity = .home
}
