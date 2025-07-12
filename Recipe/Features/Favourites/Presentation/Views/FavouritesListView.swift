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
                        onTapAddOrRemove: { favourite in
                            initDelete(favourite: favourite)
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
        
    }
    
    
    private func delete(indexSet: IndexSet){
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
