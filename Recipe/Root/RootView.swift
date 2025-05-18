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
        VStack {
            Group{
                if dashboardViewModel.isFirstTimeUsingApp{
                    LandingView()
                }
                else {
                    DashboardView()
//                    RootTabView()
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(DashboardViewModel())
}
