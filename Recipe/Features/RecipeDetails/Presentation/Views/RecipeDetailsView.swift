//
//  RecipeDetailsView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

import SwiftUI

struct RecipeDetailsView: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @State var recipe: String

    let ingredients = [
        ("soft flour tortilla", "1", "🥙"),
        ("teaspoon olive oil", "1", "🫒"),
        ("pinch garlic powder", "1", "🧄"),
        ("salt and black pepper", "10g", "🧂"),
        ("tablespoons tomato sauce", "3", "🍅"),
        // Add more ingredients as needed...
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    Image("pizza") // Replace with your image asset name
                        .resizable()
                        .scaledToFill()
                        .frame(height: 240)
                        .clipped()
                    
                    HStack(spacing: 12) {
                        Image("chef") // Replace with your chef image asset
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Chef John")
                                .font(.custom("\(themesViewModel.selectedFontPrefix)-Medium", size: 17))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            HStack {
                                Text("Follow")
                                Image(systemName: "plus")
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.bottom)
                    .background(.ultraThinMaterial)
                }

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Tortilla Pizza Recipe")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-SemiBold", size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.blackAndWhite)
                        
                        Spacer()
                        
                        Image(systemName: "bookmark")
                            .foregroundColor(Color.theme.blackAndWhite)
                    }
                    

                    Text("This tortilla pizza is extremely easy to make. It is light enough to be a snack, serves well as an appetizer, or is so good that it can be devoured alone! You can use any sort of topping variation.")
                        .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                        .foregroundColor(.secondary)

                    HStack {
                        Text("Ingredients")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Bold", size: 17))
                            .foregroundColor(Color.theme.blackAndWhite)


                        Text("(12)")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                            .foregroundColor(Color.theme.primaryColor)
                    }

                    VStack(spacing: 12) {
                        ForEach(ingredients, id: \.0) { name, quantity, icon in
                            HStack {
                                Text(icon)
                                    .font(.largeTitle)
                                
                                Text(name)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text(quantity)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                }
                .padding()
                .background(Color.theme.whiteAndBlack)
                .cornerRadius(24)
                .offset(y: -24)
                .padding(.bottom, -24)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    RecipeDetailsView(recipe: "")
        .environmentObject(ThemesViewModel())

}
