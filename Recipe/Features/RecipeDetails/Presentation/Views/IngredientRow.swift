//
//  IngredientRow.swift
//  Recipe
//
//  Created by Hummingbird on 03/07/2025.
//

import SwiftUI

struct IngredientRow: View {
    
    let ingredient: IngredientModel
    
    var body: some View {
        HStack {
            CustomImageView(
                url: ingredient.image,
                maxWidth: 60,
                height: 60
            )
            .clipShape(.rect(cornerRadius: 10))
            
            Text(ingredient.name)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(ingredient.quantity)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    IngredientRow(ingredient: RecipeModel.sampleRecipeModel.ingredients[0])
        .padding()
}
