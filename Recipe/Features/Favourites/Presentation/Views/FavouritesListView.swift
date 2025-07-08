//
//  FavouritesListView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct FavouritesListView: View {
    @State var searchField = ""
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            
            ScrollView(showsIndicators: false) {
                ForEach(0..<10, id: \.self){ item in
                    Button{
                        //router.push(.recipedetails(recipe: ""))
                    } label: {
                        FavouriteItemView()
                            .foregroundColor(Color.theme.blackAndWhite)
                    }
                }
            }
            .padding(.horizontal)
            .searchable(text: $searchField, prompt: "Search recipes...")
            .navigationTitle("Favourites")
            //.hideBottomNavigationBar(false)
        }
        
    }
}

#Preview {
    FavouritesListView()
        .environmentObject(Router())
}
