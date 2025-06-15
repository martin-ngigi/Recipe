//
//  RootView.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        VStack {
            Group{
                if LocalState.isFirstLaunch{
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
}
