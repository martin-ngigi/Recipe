//
//  LandingView.swift
//  Recipe
//
//  Created by Martin on 12/03/2025.
//

import SwiftUI

struct LandingView: View {
    @StateObject var settingsViewModel = SettingsViewModel()

    var body: some View {
        VStack(spacing: 80){
            
            Spacer()
            Spacer()
            
            VStack(spacing: 10){
                Text("Cook Like a Chef")
                    .font(.custom("Poppins-Bold", size: 34))
                
                Text("RecipeApp is a user-friendly recipe app designed for those who are new to cooking and want to try new recipes at home")
                    .font(.custom("Poppins-Light", size: 14))
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(Color.theme.blackAndWhite)
            
            
            CustomButton(
                buttonName: "Get Started",
                onTap: {
                    LocalState.isFirstLaunch = false
                }
            )
            .padding(.bottom, 10)
            
        }
        .padding()
        .background(
            ZStack{
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

#Preview{
    LandingView()
        .environment(\.locale, Locale(identifier: "sw"))
}

