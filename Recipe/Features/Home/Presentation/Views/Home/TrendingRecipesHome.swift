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
    var onTapRecipe: (RecipeModel) -> Void
    
    var body: some View {
        VStack(spacing: 5){
            HStack{
                Text("Trending Recipes")
                    .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack{
                    Text("See All")
                        .font(.custom(FontConstants.POPPINS_MEDIUM, size: 14))
                        .underline(true, color: Color.theme.primaryColor)
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.theme.grayColor1)
                }
                .foregroundColor(Color.theme.primaryColor)
                
            }
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(recipes, id: \.self) { recipe in
                    Button{
                        onTapRecipe(recipe)
                    } label: {
                        RecipeItemView(recipe: recipe)
                    }
                }
                
               
            }
        }
    }
}

//#Preview {
//    TrendingRecipes()
//}
