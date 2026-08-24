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
                    .font(.appFootnote)
                    .foregroundStyle(Color.theme.blackAndWhite)


                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color.secondary)

                    Text("\(recipe.chef?.rate?.ratingFormatted ?? "0.0")")
                        .font(.appCaption2)
                        .foregroundColor(Color.secondary)

                    Spacer()
                }
            }
        }
    }
}

// #Preview {
//    RecipeItemView()
// }
