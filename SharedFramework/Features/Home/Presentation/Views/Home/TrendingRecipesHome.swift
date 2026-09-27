/*
* Created by Martin Wainaina on 24/08/2026
*
* Feel free to contribute.
*/

//
//  TrendingRecipesHome.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import SwiftUI

struct TrendingRecipesHome: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var columns2: [GridItem] {
        if dynamicTypeSize.isAccessibilitySize {
            return [GridItem(.flexible())]
        }
        
        if horizontalSizeClass == .regular { //iPad
            return [GridItem(.adaptive(minimum: 160), spacing: 16)]
        }
        
        return [GridItem(.adaptive(minimum: 160), spacing: 16)]
    }
    var columns: [GridItem] {
        let minimumWidth: CGFloat = dynamicTypeSize.isAccessibilitySize ? 360 : 160
        return [GridItem(.adaptive(minimum: minimumWidth), spacing: 16)]
    }
    let columns4 = Array( repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 2)

    var recipes: [RecipeModel]
    var isLoading: Bool = false
    var namespace: Namespace.ID
    var isEmpty: Bool {
        return recipes.isEmpty && isLoading == false
    }
    var onTapSeeAll: () -> Void

    var body: some View {
        
        VStack(alignment: .leading, spacing: 16){
            
            HStack {
                
                Text("Trending Recipes")
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .font(.title2.bold())
                
                Spacer()
                
                if !isEmpty {
                    HStack(spacing: 4) {
                        Text("See All")
                            .font(.footnote)

                        Image(systemName: "chevron.right")
                            .imageScale(.small)

                    }
                    .accessibilityLabel("See all trending recipes")
                    .foregroundStyle(Color.theme.primaryColor)
                    .tappableArea(
                        onTap: {
                            onTapSeeAll()
                        }
                    )
                }
                
            }
            .padding(.horizontal, Guidelines.horizontalPadding)
            
            if isEmpty {
                EmptyScreenView(
                    imageName: "tray",
                    imageSize: 80,
                    title: "Trending",
                    titleSize: 18,
                    description: """
                        No trending recipes found.
                        """,
                    descriptionSize: 12
                )
                .padding(.horizontal, Guidelines.horizontalPadding)
            }
            else {
                ScrollView(.horizontal){
                    LazyVGrid(columns: columns4, spacing: 16) {
                        ForEach(recipes, id: \.self) { recipe in
                            NavigationLink {
                                RecipeDetailsView(recipe: recipe)
                                    .navigationTransition(.zoom(sourceID: recipe.recipeId, in: namespace))
                            } label: {
                                RecipeItemView(recipe: recipe)
                                    .matchedTransitionSource(id: recipe.recipeId, in: namespace)
                            }
                        }
                    }
                    .padding(.bottom, 32)
                }
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, Guidelines.horizontalPadding)
            }
        }
    }
}

#Preview {
    TrendingRecipesHome(
        recipes: HomeResponseModel.mockData?.data.trendingRecipes ?? [],
        namespace: Namespace().wrappedValue,
        onTapSeeAll: {

        }
    )
}
