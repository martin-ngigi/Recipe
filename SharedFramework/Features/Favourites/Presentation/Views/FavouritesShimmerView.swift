/*
* Created by Martin Wainaina on 15/08/2026
*
* Feel free to contribute.
*/

//
//  FavouritesShimmerView.swift
//  Recipe
//
//  Created by RAFIKI on 15/08/2026.
//

import SwiftUI

struct FavouritesShimmerView: View {
    var isLoading: Bool
    
    var body: some View {
        LazyVStack(pinnedViews: [.sectionHeaders]) {
            ForEach(RecipeModel.dummyList, id: \.self) { recipe in
                
                Section {
                    Group{
                        FavouriteItemView(
                            recipe: recipe,
                            onTapEntireItem: { recipe in
                            },
                            onTapAddOrRemove: { favourite in
                            }
                        )
                    }

                } header: {
                    FavouriteHeader(title: recipe.name)
                }
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .padding()
    }
}

#Preview {
    FavouritesShimmerView(isLoading: true)
}
