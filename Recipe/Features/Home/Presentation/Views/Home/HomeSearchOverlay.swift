//
//  HomeSearchOverlay.swift
//  Recipe
//
//  Created by Hummingbird on 27/07/2025.
//

import SwiftUI

struct HomeSearchOverlay: View {
    @Binding var isShowSearchResults: Bool
    var isLoading: Bool
    var recipes: [RecipeModel]
    var chefs: [UserModel]
    
    var body: some View {
        ZStack {
            if isShowSearchResults {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowSearchResults.toggle() // dismiss the overlay if user taps outside.
                    }
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            // ProgressView
                            if isLoading{
                                VStack(alignment: .center) {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.8)
                            }
                            
                            SearchOverlayView(
                                recipes: recipes ,
                                chefs: chefs
                            )
                            
                        }
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .padding()
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.7)
                }
            }
        }
        .offset(y: 10) // Start below the search bar
    }
}

#Preview {
    HomeSearchOverlay(
        isShowSearchResults: .constant(true),
        isLoading: false,
        recipes: HomeResponseModel.sampleData?.data.trendingRecipes ?? [],
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? []
    )
}
