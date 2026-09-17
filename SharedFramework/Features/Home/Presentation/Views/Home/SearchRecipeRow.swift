/*
* Created by Martin Wainaina on 13/09/2026
*
* Feel free to contribute.
*/

//
//  SearchRecipeRow.swift
//  Recipe
//
//  Created by RAFIKI on 12/05/2026.
//

import SwiftUI

struct SearchRecipeRow: View {

    var recipe: RecipeModel
    var onTap: (RecipeModel) -> Void

    var body: some View {
        Button {
            onTap(recipe)
        } label: {
            HStack(spacing: 8) {
                CustomImageView(
                    url: recipe.image,
                    width: 80,
                    height: 80
                )
                .clipped()
                .cornerRadius(Guidelines.cornerRadius)
                .foregroundColor(Color.theme.blackAndWhite)

                VStack {
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
            .cornerRadius(Guidelines.cornerRadius)
            .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    if let recipe = RecipeModel.dummyList.first {
        SearchRecipeRow(
            recipe: recipe,
            onTap: { _ in

            }
        )
    }

}
