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
            HStack (alignment: .top, spacing: 16){
                CustomImageView(
                    url: ingredient.image,
                    width: 64,
                    height: 64
                )
                .clipShape(.rect(cornerRadius: Guidelines.cornerRadius/2))

                VStack(alignment: .leading, spacing: 4) {
                    Text(ingredient.name)
                        .multilineTextAlignment(.leading)
                        .font(.headline)

                    Text(ingredient.quantity)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.white)

                Spacer()
            }
        }
    }
}

#Preview {
    IngredientRow(
        ingredient: RecipeModel.dummyList[0].ingredients[3],
        onTapIngredient: { _ in

        }
    )
    .padding(Guidelines.horizontalPadding)
    .background(Color(.systemGray))
    .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))
    .padding()
}
