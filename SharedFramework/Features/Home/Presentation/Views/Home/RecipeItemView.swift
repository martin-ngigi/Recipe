/*
* Created by Martin Wainaina on 16/08/2026
*
* Feel free to contribute.
*/

//
//  RecipeItemView.swift
//  Recipe
//
//  Created by Martin on 17/03/2025.
//

import SwiftUI

struct RecipeItemView: View {
    let recipe: RecipeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            CustomImageView(
                url: recipe.image,
                width: 240,
                height: 160
            )
            .foregroundColor(Color.theme.blackAndWhite)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.body.bold())
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Label(recipe.chef?.rate?.ratingFormatted ?? "0.0", systemImage: "star.fill")
                    .font(.footnote)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                    .frame(alignment: .bottom)
            }
            .lineLimit(1)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            
        }
        .frame(maxWidth: 240)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: Guidelines.cornerRadius))
        .clipped()
        .glassEffectCustomRectangular()
    }
}

 #Preview {
     RecipeItemView(recipe: RecipeModel.dummyList[1])
         .padding()
 }
