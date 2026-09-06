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
                maxWidth: 200,
                height: 140
            )
            .foregroundColor(Color.theme.blackAndWhite)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(recipe.name)
                    .font(.callout)
                    .foregroundStyle(Color.theme.blackAndWhite)

                HStack(alignment: .firstTextBaseline, spacing: 2) {

                    Text("\(Image(systemName: "star.fill")) \(recipe.chef?.rate?.ratingFormatted ?? "0.0")")
                        .font(.footnote)

                }
                .foregroundColor(Color.secondary)
            }
            .padding(8)
            
        }
        .frame(minWidth: 200)
        .background(Color(.secondarySystemBackground)) 
        .clipped()
        .cornerRadius(24)
        //.clipShape(UnevenRoundedRectangle(topLeadingRadius: 24, topTrailingRadius: 24))
        .contentShape(Rectangle())
    }
}

 #Preview {
     RecipeItemView(recipe: RecipeModel.dummyList[0])
         .padding()
 }
