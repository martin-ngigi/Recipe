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
        Button{
            onTapIngredient(ingredient)
        } label: {
            HStack {
                CustomImageView(
                    url: ingredient.image,
                    maxWidth: 60,
                    height: 60
                )
                .clipShape(.rect(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    Text(ingredient.name)
                        .font(.custom("\(LocalState.selectedFontPrefix)-Medium", size: 17))
                        .foregroundColor(.primary)
                                    
                    Text(ingredient.quantity)
                        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

#Preview {
    IngredientRow(
        ingredient: RecipeModel.dummyList[0].ingredients[0],
        onTapIngredient: { ingredient in
            
        }
    )
    .padding()
}
