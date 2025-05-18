//
//  HomeView.swift
//  Recipe
//
//  Created by Martin on 13/03/2025.
//

import SwiftUI

struct HomeView: View {
    @State var searchField = ""
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    @EnvironmentObject var tabRouter: TabRouter


    var body: some View {
        VStack{
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
                    
                    
                    JustForYouSliderView()
                    
                    // Trending Recipes
                    VStack(spacing: 5){
                        HStack{
                            Text("Trending Recipes")
                                .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.theme.primaryColor)
                                .frame(width: 20, height: 20)
                        }
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(0..<4) { index in
                                Button{
                                    tabRouter.homeRouter.push(.recipedetails(recipe: ""))
                                } label: {
                                    RecipeItemView()
                                        .foregroundColor(Color.theme.blackAndWhite)
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
        .hideBottomNavigationBar(false)
    }
}

#Preview {
    HomeView()
        .environmentObject(TabRouter())

}
