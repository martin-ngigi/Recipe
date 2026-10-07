/*
* Created by Martin Wainaina on 07/10/2026
*
* Feel free to contribute.
*/

//
//  NewRecipesSection.swift
//  Recipe
//
//  Created by RAFIKI on 28/09/2026.
//

import SwiftUI

struct NewRecipesSection: View {

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
                
                Text("New Recipes")
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
                    .accessibilityLabel("See all new recipes")
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
                    title: "New Recipes",
                    titleSize: 18,
                    description: """
                        No new recipes found.
                        """,
                    descriptionSize: 12
                )
                .padding(.horizontal, Guidelines.horizontalPadding)
            }
            else {
                ScrollView(.horizontal){
                    HStack(spacing: 8) {
                        ForEach(recipes, id: \.self) { recipe in
                            NavigationLink {
                                RecipeDetailsView(recipe: recipe)
                                    .navigationTransition(.zoom(sourceID: recipe.recipeId, in: namespace))
                            } label: {
                                NewRecipeItem(recipe: recipe )
                                    .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                        content
                                            .scaleEffect(1.0 - 0.12 * abs(phase.value))
                                    }
                                .matchedTransitionSource(id: recipe.recipeId, in: namespace)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, Guidelines.horizontalPadding, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    NewRecipesSection(
        recipes: HomeResponseModel.mockData?.data.trendingRecipes ?? [],
        namespace: Namespace().wrappedValue,
        onTapSeeAll: {

        }
    )
}
