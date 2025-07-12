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
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favouriteRecipesViewModel.favouriteRecipes, id: \.self){ recipe in
                    FavouriteItemView(
                        recipe: recipe,
                        onTapEntireItem: { recipe in
                            router.push(.recipedetails(recipe: recipe))
                        },
                        onTapAddOrRemove: { recipe in
                            Task {await favouriteRecipesViewModel.deleteFavouriteRecipe(recipe: recipe)}
                        }
                    )
                }
                .onDelete(perform: delete(indexSet:))
            }
            .listStyle(.plain)
            //.padding(.horizontal)
            .searchable(text: $searchField, prompt: "Search favourite...")
            .navigationTitle(favouriteRecipesViewModel.favouritesListViewTitle)
            .task {
                await favouriteRecipesViewModel.fetchFavouriteRecipes()
            }
            //.hideBottomNavigationBar(false)
        }
        
    }
    
    
    private func delete(indexSet: IndexSet){
        indexSet.forEach { index in
            let favourite = favouriteRecipesViewModel.favouriteRecipes[index]
            Task {await favouriteRecipesViewModel.deleteFavouriteRecipe(recipe: favourite)}
        }
    }
}

#Preview {
    FavouritesListView()
    .environmentObject(Router())
}
