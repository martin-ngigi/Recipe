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
        ScrollView(.vertical) {
            VStack(spacing: 32) {

                Image("landing")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .clipped()
                    .backgroundExtensionEffect()
                    .flexibleLandingHeaderContent()

                VStack(spacing: 8) {
                    Text("Cook Like a Chef")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .multilineTextAlignment(.center)

                    Text(
                        "RecipeApp is a user-friendly recipe app designed for those who "
                            + "are new to cooking and want to try new recipes at home."
                    )
                    .font(.callout)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                    .multilineTextAlignment(.center)
                }
                .padding(.horizontal, Guidelines.horizontalPadding)

                CustomButton(
                    buttonName: "Get Started",
                    onTap: {
                        LocalState.isFirstLaunch = false
                        router.replace(with: .dashboard)
                    }
                )
                .padding(.horizontal, Guidelines.horizontalPadding)
                .padding(.bottom, 16)

            }
        }
        .flexibleHeaderScrollView()
        .toolbar(removing: .title)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    LandingView()
        .frame(minWidth: 375.0, minHeight: 375.0)
        .onGeometryChange(for: CGSize.self) { geometry in
            geometry.size
        } action: {
            ModelData.shared.windowSize = $0
        }
}
