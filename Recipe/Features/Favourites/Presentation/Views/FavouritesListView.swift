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
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                ForEach(0..<10, id: \.self){ item in
                    FavouriteItemView()
                }
            }
            .padding()
            .searchable(text: $searchField, prompt: "Search recipes...")
            .navigationTitle("Favourites")
        }
    }
}

#Preview {
    FavouritesListView()
        .environmentObject(ThemesViewModel())
}
