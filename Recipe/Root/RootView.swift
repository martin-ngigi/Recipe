//
//  RootView.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    var body: some View {
        NavigationView {
            Group{
                if dashboardViewModel.isFirstTimeUsingApp{
                    LandingView()
                }
                else {
                    DashboardView()
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(DashboardViewModel())
}
