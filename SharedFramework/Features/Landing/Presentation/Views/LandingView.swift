/*
* Created by Martin Wainaina on 31/08/2026
*
* Feel free to contribute.
*/

//
//  LandingView.swift
//  Recipe
//
//  Created by Martin on 12/03/2025.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {

                VStack(spacing: 10) {
                    Text("Cook Like a Chef")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text(
                        "RecipeApp is a user-friendly recipe app designed for those who "
                            + "are new to cooking and want to try new recipes at home."
                    )
                    .font(.callout)
                    .multilineTextAlignment(.center)
                }
                .foregroundColor(.primary)

                CustomButton(
                    buttonName: "Get Started",
                    onTap: {
                        LocalState.isFirstLaunch = false
                        router.replace(with: .dashboard)
                    }
                )
                .padding(.bottom, 8)

            }
        }
        .defaultScrollAnchor(.bottom)
        .padding()
        .background(
            ZStack {
                Image("landing")
                    .ignoresSafeArea()

                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.theme.whiteAndBlack.opacity(0),
                            Color.theme.whiteAndBlack.opacity(0),
                            Color.theme.whiteAndBlack.opacity(0.9),
                            Color.theme.whiteAndBlack
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )

            }
        )
    }
}

#Preview {
    LandingView()
}
