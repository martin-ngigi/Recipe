//
//  HomeView.swift
//  Recipe
//
//  Created by Martin on 13/03/2025.
//

import SwiftUI

struct HomeView: View {
    @State var searchField = ""

    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false) {
                VStack{
                 
                    HStack{
                        Text("Discover Best \nRecipes")
                            .font(.custom(FontConstants.POPPINS_BOLD, size: 24))
                            .lineSpacing(0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.theme.grayColor1)
                    }
                    
                    // Search Bar
                    BorderedInputField(
                        text: $searchField,
                        placeholder: "Search recipes...",
                        error: .constant("")
                    )
                    
                    // Just for you
                    VStack(spacing: 5){
                        Text("Just For You")
                            .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Image("landing")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)
                            .contentShape(Rectangle()) // <- Ensures full image is tappable and prevents tapping issue
                            .overlay {
                                ZStack {
                                    Color.black.opacity(0.4) // Dark overlay for better text visibility
                                        .cornerRadius(10)
                                    
                                    VStack {
                                        Spacer() // Pushes the text to the bottom
                                        Text("15 best pasta recipes from chef John")
                                            .font(.custom(FontConstants.POPPINS_LIGHT, size: 18))
                                            .foregroundColor(Color.theme.whiteColor)
                                            .padding(.bottom, 8)
                                            .padding()
                                    }
                                }
                            }
                            
                    }
                    .padding(.top, 10)
                    
                    // Trending Recipes
                    VStack(spacing: 5){
                        Text("Trending Recipes")
                            .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                ForEach(0..<6){ index in
                                    RecipeItemView()
                                }
                            }
                            
                            HStack(spacing: 10){
                                ForEach(0..<6){ index in
                                    RecipeItemView()
                                }
                            }
                        }
                    }
                    .padding(.top, 10)
                }
                .padding()
                //.searchable(text: $searchField, prompt: "Search recipes...")
               
                
            }
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Dismiss") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }
        .hideBottomNavigationBar(true)
    }
}

#Preview {
    HomeView()
}
