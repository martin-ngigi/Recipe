//
//  SearchOverlayView.swift
//  Recipe
//
//  Created by Hummingbird on 27/07/2025.
//

import SwiftUI

struct SearchOverlayView: View {
    var recipes: [RecipeModel]
    var chefs: [UserModel]
    
    @State private var recipePage = 0
    @State private var chefPage = 0
    
    private let itemsPerPage = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: - Recipes Section
            Section("Recipes") {
                VStack(alignment: .leading) {
                    ForEach(paginatedItems(for: recipes, page: recipePage), id: \.self) { recipe in
                        SearchRecipeRow(recipe: recipe, onTap: { _ in })
                    }
                    
                    paginationControls(
                        currentPage: $recipePage,
                        totalItems: recipes.count,
                        label: "Recipes"
                    )
                }
            }
            
            // MARK: - Chefs Section
            Section("Chefs") {
                VStack(alignment: .leading) {
                    ForEach(paginatedItems(for: chefs, page: chefPage), id: \.self) { chef in
                        PopularChefRow(chef: chef, onTap: { _ in })
                    }
                    
                    paginationControls(
                        currentPage: $chefPage,
                        totalItems: chefs.count,
                        label: "Chefs"
                    )
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Helper for Pagination
    private func paginatedItems<T>(for items: [T], page: Int) -> [T] {
        let start = page * itemsPerPage
        let end = min(start + itemsPerPage, items.count)
        return Array(items[start..<end])
    }
    
    // MARK: - Pagination Controls
    @ViewBuilder
    private func paginationControls(currentPage: Binding<Int>, totalItems: Int, label: String) -> some View {
        let totalPages = max(1, Int(ceil(Double(totalItems) / Double(itemsPerPage))))
        
        if totalPages > 1 {
            HStack(spacing: 8) {
                Button("Prev") {
                    if currentPage.wrappedValue > 0 {
                        currentPage.wrappedValue -= 1
                    }
                }
                .disabled(currentPage.wrappedValue == 0)
                
                ForEach(0..<totalPages, id: \.self) { page in
                    Button("\(page + 1)") {
                        currentPage.wrappedValue = page
                    }
                    .font(.caption)
                    .padding(6)
                    .background(currentPage.wrappedValue == page ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(6)
                }
                
                Button("Next") {
                    if currentPage.wrappedValue < totalPages - 1 {
                        currentPage.wrappedValue += 1
                    }
                }
                .disabled(currentPage.wrappedValue == totalPages - 1)
            }
            .padding(.top, 8)
        }
    }
}


#Preview {
    SearchOverlayView(
        recipes: HomeResponseModel.sampleData?.data.trendingRecipes ?? [],
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? []
    )
}


#Preview {
    SearchOverlayView(
        recipes:  HomeResponseModel.sampleData?.data.trendingRecipes ?? [],
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? []
    )
}


struct SearchRecipeRow: View {
    
    var recipe: RecipeModel
    var onTap: (RecipeModel) -> Void

    var body: some View {
        Button{
            onTap(recipe)
        } label: {
            HStack( spacing: 8) {
                CustomImageView(
                    url: recipe.image,
                    maxWidth: 80,
                    height: 80
                )
                .clipped()
                .cornerRadius(12)
                .foregroundColor(Color.theme.blackAndWhite)

                VStack{
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundColor(Color.theme.blackAndWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    
                    Text(recipe.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
        }
    }
}


#Preview{
    SearchRecipeRow(
        recipe: RecipeModel.dummyList[0],
        onTap: { recipe in
            
        }
    )
}
