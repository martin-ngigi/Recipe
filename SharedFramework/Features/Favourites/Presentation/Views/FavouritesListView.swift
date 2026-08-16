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
    @StateObject var favouriteRecipesViewModel = FavouriteRecipesViewModel()
    @EnvironmentObject var router: Router

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                if favouriteRecipesViewModel.isLoading{
                    FavouritesShimmerView(isLoading: favouriteRecipesViewModel.isLoading)
                }
                else if favouriteRecipesViewModel.favouriteRecipes.isEmpty{
                    EmptyScreenView(
                        imageName: "tray",
                        title: "No Favourites Found",
                        description: "You haven't added any recipes to your favourites yet. Start exploring "
                            + "delicious recipes and tap the heart icon on any recipe you like to save it here "
                            + "for easy access later. Your favourite recipes will appear in this list so you can "
                            + "quickly find and enjoy them anytime."
                    )
                }
                else {
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        ForEach(favouriteRecipesViewModel.favouriteRecipes, id: \.self) { recipe in
                            
                            Section {
                                Group{
                                    if #available(iOS 17.0, *) {
                                        FavouriteItemView(
                                            recipe: recipe,
                                            onTapEntireItem: { recipe in
                                                router.push(.recipedetails(recipe: recipe))
                                            },
                                            onTapAddOrRemove: { favourite in
                                                initDelete(favourite: favourite)
                                            }
                                        )
                                    }
                                    else {
                                        FavouriteItemView(
                                            recipe: recipe,
                                            onTapEntireItem: { recipe in
                                                router.push(.recipedetails(recipe: recipe))
                                            },
                                            onTapAddOrRemove: { favourite in
                                                initDelete(favourite: favourite)
                                            }
                                        )
                                    }
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        // Delete action
                                        if let index = favouriteRecipesViewModel.favouriteRecipes.firstIndex(of: recipe) {
                                            delete(indexSet: IndexSet(integer: index))
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }

                                    Button {
                                        // Share action
                                        Task {
                                            favouriteRecipesViewModel.updateShareState(value: .isLoading)
                                            await ShareRecipeUtil.shared.shareRecipeAsPDF(
                                                recipe: recipe,
                                                onSuccess: {
                                                    favouriteRecipesViewModel.updateShareState(value: .good)
                                                    favouriteRecipesViewModel.updateIsShowAlertDialog(value: false)
                                                },
                                                onError: { error in
                                                    favouriteRecipesViewModel.updateIsShowAlertDialog(value: false)
                                                    favouriteRecipesViewModel.updateDialogEntity(
                                                        value: DialogEntity(
                                                            title: "Sharing Recipe Failed",
                                                            message: error,
                                                            icon: "",
                                                            confirmButtonText: "",
                                                            dismissButtonText: "Okay",
                                                            onConfirm: {
                                                                favouriteRecipesViewModel.updateIsShowAlertDialog(value: false)
                                                            },
                                                            onDismiss: {
                                                                favouriteRecipesViewModel.updateIsShowAlertDialog(value: false)
                                                            }
                                                        )
                                                    )
                                                }
                                            )
                                        }
                                    } label: {
                                        Label("Share", systemImage: "square.and.arrow.up")
                                    }

                                    // Add other relevant options here
                                    /*
                                    Button {
                                    } label: {
                                        Label("Contact Chef", systemImage: "phone.arrow.up.right")
                                    }
                                    */
                                }

                            } header: {
                                FavouriteHeader(title: recipe.name)
                            }
                        }
                        .onDelete(perform: delete(indexSet:))
                    }
                    .padding()
                }
            }
            .searchable(text: $favouriteRecipesViewModel.searchField, prompt: "Search favourite...")
            .navigationTitle(favouriteRecipesViewModel.favouritesListViewTitle)
            .task {
                await favouriteRecipesViewModel.fetchFavouriteRecipes()
            }

            // .hideBottomNavigationBar(false)
        }
        .fullScreenProgressOverlay(isShowing: favouriteRecipesViewModel.shareState == .isLoading)
        .overlay {
            CustomAlertDialog(
                isPresented: $favouriteRecipesViewModel.isShowAlertDialog,
                title: favouriteRecipesViewModel.dialogEntity.title,
                text: favouriteRecipesViewModel.dialogEntity.message,
                confirmButtonText: favouriteRecipesViewModel.dialogEntity.confirmButtonText,
                dismissButtonText: favouriteRecipesViewModel.dialogEntity.dismissButtonText,
                imageName: favouriteRecipesViewModel.dialogEntity.icon,
                onDismiss: {
                    if let onDismiss = favouriteRecipesViewModel.dialogEntity.onDismiss {
                        onDismiss()
                    }
                },
                onConfirmation: {
                    if let onConfirm = favouriteRecipesViewModel.dialogEntity.onConfirm {
                        onConfirm()
                    }
                }
            )
        }
        .toastView(toast: $favouriteRecipesViewModel.toast)

    }

    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let favourite = favouriteRecipesViewModel.favouriteRecipes[index]
            initDelete(favourite: favourite)
        }
    }

    func initDelete(favourite: RecipeModel) {
        favouriteRecipesViewModel.updateDialogEntity(
            value: DialogEntity(
                title: "Unmark Favourite",
                message: "Are you sure you want to unmark \(favourite.name) as a favourite? ",
                icon: "",
                confirmButtonText: "Delete",
                dismissButtonText: "Cancel",
                onConfirm: {
                    Task {
                        await favouriteRecipesViewModel.deleteFavouriteRecipe(recipe: favourite)
                        favouriteRecipesViewModel.updateIsShowAlertDialog(value: false)
                        await favouriteRecipesViewModel.sleep(nanoseconds: 500_000_000)

                        favouriteRecipesViewModel.updateToast(
                            value: Toast(
                                style: .warning,
                                message: "\(favourite.name) removed from favourites."
                            )
                        )
                    }
                },
                onDismiss: {
                    favouriteRecipesViewModel.updateIsShowAlertDialog(value: false)
                }
            )
        )
        favouriteRecipesViewModel.updateIsShowAlertDialog(value: true)

    }

}

#Preview {
    FavouritesListView()
        .environmentObject(Router())
}
