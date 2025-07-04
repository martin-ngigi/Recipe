//
//  RecipeItemView.swift
//  Recipe
//
//  Created by Martin on 17/03/2025.
//

import SwiftUI

struct RecipeItemView: View {
    let recipe: RecipeModel
    
    var body: some View {
        VStack{
            Spacer()
            
            VStack(alignment: .leading, spacing: 2){
                Spacer()
                
                Text(recipe.chef?.name ?? "--")
                    .font(.custom(FontConstants.POPPINS_MEDIUM, size: 16))
                    .foregroundColor(Color.theme.whiteColor)
                
                HStack{
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor(Color.theme.whiteColor)
                    
                    Text("\(recipe.chef?.totalRatings ?? 0.0)")
                        .font(.custom(FontConstants.POPPINS_MEDIUM, size: 12))
                        .foregroundColor(Color.theme.whiteColor)
                    
                    Spacer()
                }
            }
            .padding([.leading, .trailing, .bottom], 13)
            .frame(height: 50)
            .background(.ultraThinMaterial.opacity(0.9))
            //.cornerRadius(8)
            //.padding(.bottom, 20)
        }
        .frame(width: 170, height: 150)
        .background(
            
            CustomImageView(
                url: recipe.image,
                maxWidth: .infinity,
                height: 40
            )
            .edgesIgnoringSafeArea(.all)
            
        )
        .cornerRadius(20)
        .foregroundColor(Color.theme.blackAndWhite)
    }
}

//#Preview {
//    RecipeItemView()
//}
