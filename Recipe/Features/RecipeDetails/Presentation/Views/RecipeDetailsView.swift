//
//  RecipeDetailsView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

import SwiftUI

struct RecipeDetailsView: View {
    @State var recipe: RecipeModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    
                    CustomImageView(
                        url: recipe.image,
                        maxWidth: .infinity,
                        height: 240
                    )
                    
                    HStack(spacing: 12) {
                        
                        CustomImageView(
                            url: recipe.chef?.avatar ?? "",
                            maxWidth: 40,
                            height: 40
                        )
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recipe.chef?.name ?? "")
                                .font(.custom("\(LocalState.selectedFontPrefix)-Medium", size: 17))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            HStack {
                                Text("Follow")
                                Image(systemName: "plus")
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.bottom)
                    .background(.ultraThinMaterial)
                }

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(recipe.name)
                            .font(.custom("\(LocalState.selectedFontPrefix)-SemiBold", size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.blackAndWhite)
                        
                        Spacer()
                        
                        Image(systemName: "bookmark")
                            .foregroundColor(Color.theme.blackAndWhite)
                    }
                    

                    Text(recipe.description)
                        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                        .foregroundColor(.secondary)

                    HStack {
                        Text("Ingredients")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Bold", size: 17))
                            .foregroundColor(Color.theme.blackAndWhite)


                        Text("(\(recipe.ingredients.count))")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                            .foregroundColor(Color.theme.primaryColor)
                    }

                    VStack(spacing: 12) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            IngredientRow(ingredient: ingredient)
                        }
                         
                    }
                }
                .padding()
                .background(Color.theme.whiteAndBlack)
                .cornerRadius(24)
                .offset(y: -24)
                .padding(.bottom, -24)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color(.systemGroupedBackground))
        .hideBottomNavigationBar(true)
    }
}

#Preview {
    RecipeDetailsView(recipe: RecipeModel.sampleRecipeModel)

}
