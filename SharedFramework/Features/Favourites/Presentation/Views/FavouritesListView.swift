/*
* Created by Martin Wainaina on 12/08/2026
*
* Feel free to contribute.
*/

//
//  FavouritesListView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct FavouritesListView: View {
    @StateObject private var viewModel = FavouriteRecipesViewModel()
    @EnvironmentObject private var router: Router
    @State private var recipePendingRemoval: RecipeModel?
    @State private var shareErrorMessage: String?

    var body: some View {
        NavigationView{
            Group{
                if viewModel.isLoading {
                    FavouritesShimmerView()
                } else if viewModel.favouriteRecipes.isEmpty {
                    emptyState
                } else {
                    recipesGrid
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle(viewModel.favouritesListViewTitle)
            .navigationBarTitleDisplayMode(.large)
            .scrollEdgeEffectStyle(.soft, for: .top)
            .searchable(text: $viewModel.searchField, prompt: "Search favourites")
            .refreshable { await viewModel.fetchFavouriteRecipes() }
            .task { await viewModel.fetchFavouriteRecipes() }
            .confirmationDialog(
                "Remove from Favourites?",
                isPresented: isConfirmingRemoval,
                titleVisibility: .visible,
                presenting: recipePendingRemoval
            ) { recipe in
                Button("Remove", role: .destructive) { remove(recipe) }
                Button("Cancel", role: .cancel) {}
            } message: { recipe in
                Text("“\(recipe.name)” will be removed from your favourites.")
            }
            .alert("Couldn’t Share Recipe", isPresented: isShowingShareError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(shareErrorMessage ?? "")
            }
            .fullScreenProgressOverlay(isShowing: viewModel.shareState == .isLoading)
            .toastView(toast: $viewModel.toast)
        }
    }

    private var recipesGrid: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                LazyVGrid(columns: FavouritesLayout.columns, spacing: FavouritesLayout.spacing) {
                    ForEach(viewModel.favouriteRecipes, id: \.self) { recipe in
                        FavouriteItemView(
                            recipe: recipe,
                            onTap: { router.push(.recipedetails(recipe: recipe)) },
                            onTapFavourite: { recipePendingRemoval = recipe }
                        )
                        .contextMenu {
                            Button {
                                share(recipe)
                            } label: {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }

                            Button(role: .destructive) {
                                recipePendingRemoval = recipe
                            } label: {
                                Label("Remove from Favourites", systemImage: "heart.slash")
                            }
                        }
                    }
                }
                //.animation(.default, value: viewModel.favouriteRecipes)
            }
            .padding(.horizontal, FavouritesLayout.spacing)
            .padding(.vertical, 8)
        }
        .scrollIndicators(.hidden)
    }

    @ViewBuilder
    private var emptyState: some View {
        if viewModel.searchField.isEmpty {
            ContentUnavailableView(
                "No Favourites Yet",
                systemImage: "heart",
                description: Text("Tap the heart on any recipe to save it here for quick access.")
            )
        } else {
            ContentUnavailableView.search(text: viewModel.searchField)
        }
    }

    private func remove(_ recipe: RecipeModel) {
        Task {
            await viewModel.deleteFavouriteRecipe(recipe: recipe)
            viewModel.updateToast(
                value: Toast(
                    style: .warning,
                    message: "\(recipe.name) removed from favourites."
                )
            )
        }
    }

    private func share(_ recipe: RecipeModel) {
        Task {
            viewModel.updateShareState(value: .isLoading)
            await ShareRecipeUtil.shared.shareRecipeAsPDF(
                recipe: recipe,
                onSuccess: {
                    viewModel.updateShareState(value: .good)
                },
                onError: { error in
                    viewModel.updateShareState(value: .good)
                    shareErrorMessage = error
                }
            )
        }
    }

    private var isConfirmingRemoval: Binding<Bool> {
        Binding(
            get: { recipePendingRemoval != nil },
            set: { if !$0 { recipePendingRemoval = nil } }
        )
    }

    private var isShowingShareError: Binding<Bool> {
        Binding(
            get: { shareErrorMessage != nil },
            set: { if !$0 { shareErrorMessage = nil } }
        )
    }
}

#Preview {
    FavouritesListView()
        .environmentObject(Router())
}
