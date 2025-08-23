//
//  HomeSearchOverlay.swift
//  Recipe
//
//  Created by Hummingbird on 27/07/2025.
//

import SwiftUI

struct HomeSearchOverlay: View {
    @Binding var searchField: String
    @Binding var isShowSearchResults: Bool
    var isLoading: Bool
    var onSearchTextChange: (String) -> Void
    var recipes: [RecipeModel]
    var chefs: [UserModel]
    var onTapRecipe: (RecipeModel) -> Void
    var onTapChef: (UserModel) -> Void
    
    var body: some View {
        ZStack {
            if isShowSearchResults {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowSearchResults.toggle() // dismiss the overlay if user taps outside.
                    }
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            BorderedInputField(
                                text: $searchField,
                                placeholder: "Search recipes...",
                                error: "",
                                hasClearButton: true,
                                onTextChange: { text in
                                    onSearchTextChange(text)
                                }
                            )
                            
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
                                chefs: chefs,
                                onTapRecipe: { recipe in
                                    onTapRecipe(recipe)
                                },
                                onTapChef: { chef in
                                    onTapChef(chef)
                                }
                            )
                            
                        }
                    }
                    .background(Color.theme.whiteAndBlack.opacity(0.9))
                    .cornerRadius(11)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.94)
                    .overlay(
                           RoundedRectangle(cornerRadius: 11)
                            .stroke(Color.theme.primaryColor, lineWidth: 1)
                       )
                    .padding()
                    .shadow(radius: 10)
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.7)
                }
            }
        }
        //.offset(y: 10) // Start below the search bar
    }
}

#Preview {
    HomeSearchOverlay(
        searchField: .constant(""),
        isShowSearchResults: .constant(true),
        isLoading: false,
        onSearchTextChange: { text in
            
        },
        recipes: HomeResponseModel.sampleData?.data.trendingRecipes ?? [],
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? [],
        onTapRecipe: { recipe in
            
        },
        onTapChef: { chef in
            
        }
    )
}
