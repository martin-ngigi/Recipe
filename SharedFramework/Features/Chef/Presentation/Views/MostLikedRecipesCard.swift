/*
* Created by Martin Wainaina on 26/08/2026
*
* Feel free to contribute.
*/

//
//  MostLikedRecipesCard.swift
//  Recipe
//
//  Created by RAFIKI on 26/08/2026.
//

import SwiftUI

struct MostLikedRecipesCard: View {
    
    var recipe: RecipeModel
    
    var body: some View {
        VStack(alignment: .leading){
            CustomImageView(
                url: recipe.image,
                maxWidth: 300,
                height: 200
            )
            .clipped()
            .cornerRadius(24)
            .foregroundColor(Color.theme.blackAndWhite)

            VStack(alignment: .leading, spacing: 2){
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(Color.theme.blackAndWhite)
                    .lineLimit(1)
                
                Text("\(recipe.chef?.rate?.ratingFormatted ?? "0.0") Rating")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
           
        }
        .frame(width: 300, height: 280)
        
    }
}

#Preview {
    MostLikedRecipesCard(recipe: RecipeModel.dummyList[0])
}
