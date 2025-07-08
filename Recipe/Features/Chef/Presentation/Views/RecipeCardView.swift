//
//  RecipeCardView.swift
//  Recipe
//
//  Created by Hummingbird on 04/07/2025.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: RecipeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CustomImageView(url: recipe.image, maxWidth: .infinity, height: 180)
                .cornerRadius(12)

            Text(recipe.name)
                .font(.custom("\(LocalState.selectedFontPrefix)-SemiBold", size: 16))
                .foregroundColor(Color.theme.blackAndWhite)

            Text(recipe.description)
                .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding()
        .background(Color.theme.whiteAndBlack)
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}


#Preview {
    RecipeCardView(recipe: RecipeModel.dummyList[0])
}
