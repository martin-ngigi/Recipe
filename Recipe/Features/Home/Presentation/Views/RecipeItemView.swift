//
//  RecipeItemView.swift
//  Recipe
//
//  Created by Martin on 17/03/2025.
//

import SwiftUI

struct RecipeItemView: View {
    var body: some View {
        VStack{
            Spacer()
            
            VStack(alignment: .leading, spacing: 2){
                Text("Title here")
                    .font(.custom(FontConstants.POPPINS_MEDIUM, size: 16))
                    .foregroundColor(Color.theme.whiteColor)
                
                HStack{
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor(Color.theme.whiteColor)
                    
                    Text("4.5")
                        .font(.custom(FontConstants.POPPINS_MEDIUM, size: 12))
                        .foregroundColor(Color.theme.whiteColor)
                    
                    Spacer()
                }
            }
            .padding(5)
            .frame(width: 186, height: 69)
            .background(Color.theme.blackAndWhite.opacity(0.4))
            .cornerRadius(8)
            .padding(.bottom, 20)
        }
        .frame(width: 220, height: 200)
        .background(
            Image("pizza")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        )
        .cornerRadius(20)
    }
}

#Preview {
    RecipeItemView()
}
