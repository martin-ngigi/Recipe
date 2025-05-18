//
//  FavouritesListView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct FavouritesListView: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @State var searchField = ""
    @EnvironmentObject var tabRouter: TabRouter

    var body: some View {
        VStack {
            
            ScrollView(showsIndicators: false) {
                ForEach(0..<10, id: \.self){ item in
                    Button{
                        tabRouter.favouritesRouter.push(.recipedetails(recipe: ""))

                    } label: {
                        FavouriteItemView()
                            .foregroundColor(Color.theme.blackAndWhite)
                    }
                }
            }
            .padding(.horizontal)
            .searchable(text: $searchField, prompt: "Search recipes...")
            .navigationTitle("Favourites")
            .hideBottomNavigationBar(false)
        }
        
    }
}

#Preview {
    FavouritesListView()
        .environmentObject(ThemesViewModel())
        .environmentObject(TabRouter())
}
