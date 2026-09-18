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
    var columns: [GridItem]
    var recipes: [RecipeModel]
    var isLoading: Bool = false
    var isEmpty: Bool {
        return recipes.isEmpty && isLoading == false
    }
    var onTapRecipe: (RecipeModel) -> Void
    var onTapSeeAll: () -> Void

    var body: some View {
        VStack(spacing: 2) {
            HStack {
                Text("Trending Recipes")
                    .font(.custom(FontConstants.POPPINS_MEDIUM, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                if !isEmpty {
                    Button {
                        onTapSeeAll()
                    } label: {
                        HStack {
                            Text("See All")
                                .font(.appFootnote)
                                .foregroundStyle(Color.theme.primaryColor)

                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 8, height: 8)
                                .foregroundColor(Color.secondary)
                        }
                        .foregroundColor(Color.theme.primaryColor)
                        .frame(minHeight: 44)
                    }
                    .accessibilityLabel("See all trending recipes")
                }

            }

            if recipes.isEmpty && isLoading == false {
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
            }
            else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(recipes, id: \.self) { recipe in
                        Button {
                            onTapRecipe(recipe)
                        } label: {
                            RecipeItemView(recipe: recipe)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TrendingRecipesHome(
        columns: [GridItem(.flexible()), GridItem(.flexible())],
        recipes: RecipeModel.dummyList,
        onTapRecipe: { _ in

        },
        onTapSeeAll: {

        }
    )
}
