//
//  SearchOverlayView.swift
//  Recipe
//
//  Created by Hummingbird on 27/07/2025.
//

import SwiftUI

struct SearchOverlayView: View {
    
    var recipes: [RecipeModel]
    var chefs: [UserModel]
    
    var body: some View {
        VStack(alignment:.leading){
            Section("Recipes"){
                VStack{
                    ForEach(recipes, id: \.self){ recipe in
                        SearchRecipeRow(
                            recipe: recipe,
                            onTap: { recipe in
                                
                            }
                        )
                    }
                }
            }
            
            Section("Chefs"){
                VStack{
                    ForEach(chefs, id: \.self){ chef in
                        PopularChefRow(
                            chef: chef,
                            onTap: { chef in
                                
                            }
                        )
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchOverlayView(
        recipes:  HomeResponseModel.sampleData?.data.trendingRecipes ?? [],
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? []
    )
}


struct SearchRecipeRow: View {
    
    var recipe: RecipeModel
    var onTap: (RecipeModel) -> Void

    var body: some View {
        Button{
            onTap(recipe)
        } label: {
            HStack( spacing: 8) {
                CustomImageView(
                    url: recipe.image,
                    maxWidth: 80,
                    height: 80
                )
                .clipped()
                .cornerRadius(12)
                .foregroundColor(Color.theme.blackAndWhite)

                VStack{
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundColor(Color.theme.blackAndWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    
                    Text(recipe.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
        }
    }
}

//
//#Preview{
//    SearchRecipeRow(
//        recipe: RecipeModel.dummyList[0],
//        onTap: { recipe in
//            
//        }
//    )
//}
