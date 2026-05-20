//
//  DashboardView.swift
//  Recipe
//
//  Created by Martin on 24/03/2025.
//

import SwiftUI
import os

struct DashboardView: View {
    @StateObject var dashboardViewModel = DashboardViewModel()
    @EnvironmentObject var tabRouter: TabRouter

    var body: some View {
        Group{
            if #available(iOS 26.0, *) {
                NavBariOS26AndAbove()
            }
            else {
                NavBariOS26AndBelow(dashboardViewModel: dashboardViewModel)
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(TabRouter())
}
