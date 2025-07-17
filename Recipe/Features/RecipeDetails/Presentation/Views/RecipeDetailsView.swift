//
//  RecipeDetailsView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct RecipeDetailsView: View {
    @State var recipe: RecipeModel
    @State var isShowAllItems = false
    @EnvironmentObject var router: Router
    @StateObject var favouriteRecipesViewModel = FavouriteRecipesViewModel()
    @StateObject var recipeDetailsViewModels = RecipeDetailsViewModels()
    @State var isInFavourite = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    
                    CustomImageView(
                        url: recipe.image,
                        maxWidth: .infinity,
                        height: 240
                    )
                    .overlay(alignment: .topLeading) {
                        Button{
                            router.pop()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(Color.theme.primaryColor)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding([.leading], 30)
                        .padding(.top, 60)
                    }
                    
                    HStack(spacing: 12) {
                        Button{
                            if let chef = recipe.chef {
                                router.push(.chefdetails(chef: chef))
                            }
                        } label: {
                            HStack(spacing: 12) {
                                CustomImageView(
                                    url: recipe.chef?.avatar ?? "",
                                    maxWidth: 40,
                                    height: 40
                                )
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(recipe.chef?.name ?? "")
                                        .font(.custom("\(LocalState.selectedFontPrefix)-Medium", size: 17))
                                        .lineSpacing(3.0)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        
                        
                        Spacer()
                        
                        Button{
                            recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
                            recipeDetailsViewModels.updateDialogEntity(
                                value: DialogEntity(
                                    title: "Coming soon.",
                                    message: "Follow your favorite chefs to get notified about new recipes and exclusive offers is coming soon.",
                                    icon: "",
                                    confirmButtonText: "",
                                    dismissButtonText: "Okay",
                                    onConfirm: {
                                        recipeDetailsViewModels.updateIsShowAlertDialog(value: false)
                                    },
                                    onDismiss: {
                                        recipeDetailsViewModels.updateIsShowAlertDialog(value: false)
                                    }
                                )
                            )
                        } label:  {
                            HStack {
                                Text("Follow")
                                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                                
                                Image(systemName: "plus")
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.bottom)
                    .background(.ultraThinMaterial)
                }

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(recipe.name)
                            .font(.custom("\(LocalState.selectedFontPrefix)-SemiBold", size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.blackAndWhite)
                        
                        Spacer()
                                                
                        Button{
                            Task{
                                if isInFavourite {
                                    await favouriteRecipesViewModel.deleteFavouriteRecipe(recipe: recipe)
                                    recipe.isInFavorite = false
                                    print("DEBUG: Removed from favourite")
                                }
                                else {
                                    recipe.isInFavorite = true
                                    await favouriteRecipesViewModel.addRecipeToFavourite(recipe: recipe)
                                    print("DEBUG: Added to favourite")
                                }
                                isInFavourite = await  favouriteRecipesViewModel.checkIfIsInFavourites(recipe: recipe)
                            }
                        } label: {
                            Image(systemName: isInFavourite ? "heart.fill" : "heart") //bookmark
                                .foregroundColor(Color.theme.primaryColor)
                                .padding(5)
                        }
                    
                    }
                    

                    Text(recipe.description)
                        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                        .foregroundColor(.secondary)

                    HStack {
                        Text("Ingredients")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Bold", size: 17))
                            .foregroundColor(Color.theme.blackAndWhite)


                        Text("(\(recipe.ingredients.count))")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                            .foregroundColor(Color.theme.primaryColor)
                    }

                    VStack(spacing: 12) {
                        if recipe.ingredients.count > 3{
                            VStack(spacing: 2) {
                                
                                ForEach(recipe.ingredients.prefix(isShowAllItems ? recipe.ingredients.count :  3), id: \.self) { ingredient in
                                    IngredientRow(ingredient: ingredient)
                                }
                                
                                HStack {
                                    Spacer()
                                    Text(isShowAllItems ? "...show less" : "...\(recipe.ingredients.count - 3) more items")
                                        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                                        .foregroundColor(Color.theme.primaryColor)
                                        .padding(.vertical)
                                        .onTapGesture {
                                            isShowAllItems.toggle()
                                        }
                                }
                            }
                        }
                        else {
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                IngredientRow(ingredient: ingredient)
                            }
                        }
                    }
                    
                    
                    VStack {
                        Text("Instructions")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Bold", size: 17))
                            .foregroundColor(Color.theme.blackAndWhite)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ForEach(Array(recipe.inststuctionsList.enumerated()), id: \.element) { index, instruction in
                            HStack(alignment: .top) {
                                Text("\(index + 1)).")
                                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                                    .foregroundColor(Color.theme.blackAndWhite)
                                    .frame(width: 24, alignment: .leading)
                                
                                Text(instruction)
                                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                                    .foregroundColor(Color.theme.blackAndWhite)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.theme.whiteAndBlack)
                .cornerRadius(24)
                .offset(y: -24)
                .padding(.bottom, -24)
            }
        }
        .task{
            isInFavourite = await favouriteRecipesViewModel.checkIfIsInFavourites(recipe: recipe)
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color(.systemGroupedBackground))
        .overlay {
            CustomAlertDialog(
                isPresented: $recipeDetailsViewModels.isShowAlertDialog,
                title: recipeDetailsViewModels.dialogEntity.title,
                text: recipeDetailsViewModels.dialogEntity.message,
                confirmButtonText: recipeDetailsViewModels.dialogEntity.confirmButtonText,
                dismissButtonText: recipeDetailsViewModels.dialogEntity.dismissButtonText,
                imageName: recipeDetailsViewModels.dialogEntity.icon,
                onDismiss: {
                    if let onDismiss = recipeDetailsViewModels.dialogEntity.onDismiss {
                        onDismiss()
                    }
                },
                onConfirmation: {
                    if let onConfirm = recipeDetailsViewModels.dialogEntity.onConfirm {
                        onConfirm()
                    }
                }
            )
        }

        //.hideBottomNavigationBar(true)
    }
}

#Preview {
    if let recipe = RecipeModel.dummyList.first {
        RecipeDetailsView(recipe: recipe)
            .environmentObject(Router())
    }
  
}
