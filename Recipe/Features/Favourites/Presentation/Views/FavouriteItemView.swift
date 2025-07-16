//
//  FavouriteItemView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct FavouriteItemView: View {
    var recipe: RecipeModel
    var onTapEntireItem: (RecipeModel) -> Void
    var onTapAddOrRemove: (RecipeModel) -> Void
    
    var body: some View {
        Button{
            onTapEntireItem(recipe)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                CustomImageView(
                    url: recipe.image,
                    maxWidth: .infinity,
                    height: 200
                )
                .clipped()
                .cornerRadius(12)

                HStack{
                    Text(recipe.name)
                        .font(.headline)
                        .lineLimit(1)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.6, alignment: .leading)
                    
                    Spacer()
                    
                    Button{
                        onTapAddOrRemove(recipe)
                    } label: {
                        Image(systemName: recipe.isInFavorite ?? false ? "heart.fill" : "heart")
                            .foregroundColor(Color.theme.primaryColor)
                            .padding(5)
                    }
                }
                .foregroundColor(Color.theme.blackAndWhite)
                
                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    FavouriteItemView(
        recipe: RecipeModel.dummyList[0],
        onTapEntireItem: { recipe in
            
        },
        onTapAddOrRemove: { recipe in
            
        }
    )
    .padding()
    .environmentObject(ThemesViewModel())

}
