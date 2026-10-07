/*
* Created by Martin Wainaina on 07/10/2026
*
* Feel free to contribute.
*/

//
//  NewRecipeItem.swift
//  Recipe
//
//  Created by RAFIKI on 28/09/2026.
//

import SwiftUI

struct NewRecipeItem: View {
    let recipe: RecipeModel
    var imageWidth: CGFloat = 360
    var imageHeight: CGFloat = 240
    var hasRating: Bool = true
    var hasChefName: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            CustomImageView(
                url: recipe.image,
                width: imageWidth,
                height: imageHeight
            )
            .foregroundColor(Color.theme.blackAndWhite)
            .overlay(alignment: .bottomLeading) {
                
                Text(recipe.name)
                    .font(.footnote)
                    .fontWidth(.expanded)
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: Guidelines.cornerRadius - 8))
                    .clipped()
                    .padding(8)
            }
            
            
        }
        .frame(maxWidth: imageWidth)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: Guidelines.cornerRadius))
        .clipped()
        .glassEffectCustomRectangular()
    }
}

#Preview {
    NewRecipeItem(
        recipe: RecipeModel.dummyList[1],
    )
    
}
