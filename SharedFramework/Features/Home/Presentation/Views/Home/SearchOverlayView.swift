//
//  SearchOverlayView.swift
//  Recipe
//
//  Created by Hummingbird on 27/07/2025.
//

import SwiftUI

struct SearchOverlayView: View {
    @Binding var recipePage: Int
    @Binding var chefPage: Int
    var recipes: [RecipeModel]
    var chefs: [UserModel]
    var onTapRecipe: (RecipeModel) -> Void
    var onTapChef: (UserModel) -> Void

    private let itemsPerPage = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Section("Recipes") {
                VStack(alignment: .leading) {
                    if recipes.isEmpty {
                        Text("No recipes found. Try searching for something else.")
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(.secondary)
                    }
                    else {
                        ForEach(paginatedItems(for: recipes, page: recipePage), id: \.self) { recipe in
                            SearchRecipeRow(
                                recipe: recipe,
                                onTap: { recipe in
                                    onTapRecipe(recipe)
                                }
                            )
                        }
                    }

                    paginationControls(
                        currentPage: $recipePage,
                        totalItems: recipes.count,
                        label: "Recipes"
                    )
                }
            }

            Section("Chefs") {
                VStack(alignment: .leading) {
                    if chefs.isEmpty {
                        Text("No chefs found. Try searching for something else.")
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(.secondary)
                    }
                    else {
                        ForEach(paginatedItems(for: chefs, page: chefPage), id: \.self) { chef in
                            PopularChefRow(
                                chef: chef,
                                onTap: { chef in
                                    onTapChef(chef)
                                }
                            )
                        }

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

    private func paginatedItems<T>(for items: [T], page: Int) -> [T] {
        let start = page * itemsPerPage
        let end = min(start + itemsPerPage, items.count)
        return Array(items[start..<end])
    }

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
        recipePage: .constant(0),
        chefPage: .constant(0),
        recipes: HomeResponseModel.sampleData?.data.trendingRecipes ?? [],
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? [],
        onTapRecipe: { _ in

        },
        onTapChef: { _ in

        }
    )
}

#Preview {
    SearchOverlayView(
        recipePage: .constant(0),
        chefPage: .constant(0),
        recipes: HomeResponseModel.sampleData?.data.trendingRecipes ?? [],
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? [],
        onTapRecipe: { _ in

        },
        onTapChef: { _ in

        }
    )
}

#Preview {
    SearchRecipeRow(
        recipe: RecipeModel.dummyList[0],
        onTap: { _ in

        }
    )
}
