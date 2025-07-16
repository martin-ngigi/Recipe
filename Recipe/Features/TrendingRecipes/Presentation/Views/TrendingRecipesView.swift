//
//  TrendingRecipesView.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import SwiftUI

struct TrendingRecipesView: View {
    var list: [RecipeModel]
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            List {
                ForEach(list, id: \.self) { recipe in
                    VStack(spacing: 10) {
                        RecipeCard(
                            recipe: recipe,
                            onTap: { recipe in
                                router.push(.recipedetails(recipe: recipe))
                            }
                        )
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Trending Recipes")
            //.hideBottomNavigationBar(false)
        }
    }
}

#Preview {
    TrendingRecipesView(list: RecipeModel.dummyList)
        .environmentObject(Router())
}
