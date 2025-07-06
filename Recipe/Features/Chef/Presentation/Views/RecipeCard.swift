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
            AsyncImage(url: URL(string: recipe.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.gray.opacity(0.2)
                }
            }
            .frame(height: 200)
            .clipped()
            .cornerRadius(12)

            Text(recipe.name)
                .font(.headline)
            Text(recipe.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(3)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}


//#Preview {
//    RecipeCard()
//}
