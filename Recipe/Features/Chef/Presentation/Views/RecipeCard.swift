//
//  RecipeCard.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import SwiftUI

struct RecipeCard: View {
    var recipe: RecipeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CustomImageView(
                url: recipe.image,
                maxWidth: .infinity,
                height: 200
            )
            .clipped()
            .cornerRadius(12)

            Text(recipe.name)
                .font(.headline)
                .lineLimit(1)
            
            Text(recipe.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(3)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
    }
}


//#Preview {
//    RecipeCard()
//}
