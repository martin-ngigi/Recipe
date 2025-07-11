//
//  FavouritesListView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct FavouritesListView: View {
    @StateObject var favouriteRecipesViewModel = FavouriteRecipesViewModel()
    @State var searchField = ""
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("\(favouriteRecipesViewModel.favouriteRecipes.count) favourite recipes")
            ScrollView(showsIndicators: false) {
                ForEach(favouriteRecipesViewModel.favouriteRecipes, id: \.self){ recipe in
                    Button{
                        router.push(.recipedetails(recipe: recipe))
                    } label: {
                        Text(recipe.name)
//                        FavouriteItemView()
//                            .foregroundColor(Color.theme.blackAndWhite)
                    }
                }
            }
            .padding(.horizontal)
            .searchable(text: $searchField, prompt: "Search recipes...")
            .navigationTitle("Favourites")
            .task {
                await favouriteRecipesViewModel.fetchFavouriteRecipes()
            }
            //.hideBottomNavigationBar(false)
        }
        
    }
}

#Preview {
    FavouritesListView()
        .environmentObject(Router())
}
