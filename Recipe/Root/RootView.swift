//
//  RootView.swift
//  Recipe
//
//  Created by Martin on 02/04/2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        NavigationStack(path: $router.path) {
            Group{
                if LocalState.isFirstLaunch{
                    LandingView()
                }
                else {
                    DashboardView()
                }
            }
            .navigationDestination(for: Route.self) { route in
                viewForRoute(route, router: router)
            }
        }
    }
}

#Preview {
    RootView()
}
