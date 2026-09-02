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
        VStack(alignment: .leading, spacing: 4) {

            CustomImageView(
                url: recipe.image,
                maxWidth: 180,
                height: 140
            )
            .foregroundColor(Color.theme.blackAndWhite)
            .clipped()
            .cornerRadius(24)
            .contentShape(Rectangle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(recipe.name)
                    .font(.callout)
                    .foregroundColor(Color.theme.primaryColor)

                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Image(systemName: "star.fill")
                        .imageScale(.small)

                    Text("\(recipe.chef?.rate?.ratingFormatted ?? "0.0")")
                        .font(.footnote)

                    Spacer()
                }
                .foregroundColor(Color.secondary)

            }
        }
    }
}

 #Preview {
     RecipeItemView(recipe: RecipeModel.dummyList[0])
         .padding()
 }
