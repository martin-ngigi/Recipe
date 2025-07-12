//
//  FavouriteItemView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct FavouriteItemView1: View {
    @State var isFavourite: Bool = false

    var body: some View {
        HStack{
            Image("pizza")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: 120, height: 100)

            VStack(alignment: .leading){
                
                Button{
                    isFavourite.toggle()
                } label: {
                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(Color.theme.primaryColor)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

                
                Text("Pizza")
                    .font(.custom("\(LocalState.selectedFontPrefix)-Medium", size: 14))
                    .lineLimit(1)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                
                Spacer()
            }
        }
        .frame(maxHeight: 100)
    }
}

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
                        Image(systemName: "heart.fill")
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
