/*
* Created by Martin Wainaina on 13/09/2026
*
* Feel free to contribute.
*/

//
//  IngredientRow.swift
//  Recipe
//
//  Created by Hummingbird on 03/07/2025.
//

import SwiftUI

struct IngredientRow: View {

    let ingredient: IngredientModel
    var onTapIngredient: (IngredientModel) -> Void

    var body: some View {
        Button {
            onTapIngredient(ingredient)
        } label: {
            HStack {
                CustomImageView(
                    url: ingredient.image,
                    width: 60,
                    height: 60
                )
                .clipShape(.rect(cornerRadius: Guidelines.cornerRadius/2))

                VStack(alignment: .leading) {
                    Text(ingredient.name)
                        .font(.headline)

                    Text(ingredient.quantity)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.white)

                Spacer()
            }
        }
        .padding(8)
    }
}

#Preview {
    IngredientRow(
        ingredient: RecipeModel.dummyList[0].ingredients[2],
        onTapIngredient: { _ in

        }
    )
    .background(Color(.systemGray))
    .padding()
}
