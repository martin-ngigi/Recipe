/*
* Created by Martin Wainaina on 16/08/2026
*
* Feel free to contribute.
*/

//
//  RecipeDetailsView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI
import os

struct RecipeDetailsView: View {
    var recipe: RecipeModel
    @EnvironmentObject var router: Router
    @StateObject var favouriteRecipesViewModel = FavouriteRecipesViewModel()
    @StateObject var recipeDetailsViewModels = RecipeDetailsViewModels()
    @State var isShowDeleteDialog = false
    @State var isDeleteSuppressed = false

    var body: some View {
        ScrollView {
            if let recipe = recipeDetailsViewModels.recipe {
                VStack(spacing: 8) {
                    
                    Spacer(minLength: UIScreen.main.bounds.height * 0.4)
                    
                    VStack{
                        Button {
                            if let chef = recipe.chef {
                                router.push(.chefdetails(chef: chef))
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 16) {
                                var avatar: String {
                                    if "\( recipe.chef?.avatar ?? "")".starts(with: "http") {
                                        return recipe.chef?.avatar ?? ""
                                    }
                                    else {
                                        return "\(Constants.BASE_URL)\( recipe.chef?.avatar ?? "")"
                                    }
                                }

                                CustomImageView(
                                    url: avatar,
                                    width: 64,
                                    height: 64
                                )
                                .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 4) {

                                    Text(recipe.chef?.name ?? "")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                    Text("View Profile & Recipes")
                                        .font(.callout)
                                }
                                .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .imageScale(.small)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(Guidelines.horizontalPadding)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))

                        VStack(alignment: .leading, spacing: 32) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(recipe.name)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)

                                    Spacer()

                                    Button {
                                        Task { await onTapDelete()  }
                                    } label: {
                                        Image(systemName: recipeDetailsViewModels.isInFavourite ? "heart.fill" : "heart")
                                            .foregroundColor(Color.theme.primaryColor)
                                            .padding(4)
                                    }
                                    .confirmationDialog("Remove from favourites", isPresented: $isShowDeleteDialog) {
                                        Button("Remove", role: .destructive){
                                            Task{ await removeFromFavourites() }
                                        }
                                    } message: {
                                        Text("Are you sure you wish to remove this item from favourites ?")
                                    }
                                    .dialogIcon(Image("trash"))
                                    .dialogSuppressionToggle(isSuppressed: $isDeleteSuppressed)

                                }
                                
                                Text(recipe.description)
                                    .font(.callout)
                                    .foregroundColor(.white)
                            }
                            
                            HStack(spacing: 8) {
                                statTile(icon: "list.bullet", value: "\(recipe.ingredients.count)", label: "Ingredients")
                                statTile(icon: "checklist", value: "\(recipe.inststuctionsList.count)", label: "Steps")
                            }
                        }
                        .padding(Guidelines.horizontalPadding)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .lastTextBaseline ,spacing: 4) {
                                Text("Ingredients")
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                Text("(\(recipe.ingredients.count))")
                                    .font(.caption)

                                Spacer()

                            }
                            
                            VStack(spacing: 8) {
                                if recipe.ingredients.count > 3 {
                                    VStack(spacing: 8) {

                                        let recipes = recipe.ingredients.prefix(recipeDetailsViewModels.isShowAllItems ? recipe.ingredients.count : 3 )
                                        
                                        ForEach( recipes, id: \.self ) { ingredient in
                                            IngredientRow(
                                                ingredient: ingredient,
                                                onTapIngredient: { ingredient in
                                                    withAnimation(.spring()) {
                                                        recipeDetailsViewModels.updateIsIngredientImage(
                                                            value: ingredient.image
                                                        )
                                                        recipeDetailsViewModels.updateIsShowIngredientImageOverlay(
                                                            value: true
                                                        )
                                                    }
                                                }
                                            )
                                        }

                                        HStack {
                                            Spacer()
                                            Text(
                                                recipeDetailsViewModels.isShowAllItems
                                                    ? "...show less" : "...\(recipe.ingredients.count - 3) more items"
                                            )
                                            .font(.body)
                                            .foregroundColor(Color.theme.primaryColor)
                                            .padding(.vertical)
                                            .onTapGesture {
                                                recipeDetailsViewModels.isShowAllItems.toggle()
                                            }
                                        }
                                    }
                                }
                                else {
                                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                                        IngredientRow(
                                            ingredient: ingredient,
                                            onTapIngredient: { ingredient in
                                                withAnimation(.spring()) {
                                                    recipeDetailsViewModels.updateIsIngredientImage(value: ingredient.image)
                                                    recipeDetailsViewModels.updateIsShowIngredientImageOverlay(value: true)
                                                }
                                            }
                                        )
                                    }
                                }
                            }

                        }
                        .foregroundStyle(.white)
                        .padding(Guidelines.horizontalPadding)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .lastTextBaseline ,spacing: 4) {
                                Text("Instructions")
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                Text("(\(recipe.inststuctionsList.count))")
                                    .font(.caption)

                                Spacer()

                            }
                            
                            VStack(spacing: 8) {
                                ForEach(Array(recipe.inststuctionsList.enumerated()), id: \.offset) { index, instruction in
                                    
                                    HStack(alignment: .top, spacing: 8) {
                                        Text("\(index + 1)")
                                            .font(.subheadline.weight(.bold))
                                            .foregroundStyle(.white)
                                            .padding(12)
                                            .background(Color.white.opacity(0.2), in: Circle())
                                        
                                        Text(instruction)
                                            .font(.body)
                                            .foregroundColor(.white)
                                            .lineSpacing(4)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.top, 2)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    
                                    if index < recipe.inststuctionsList.count - 1 {
                                        Divider()
                                            .background(.white)
                                            .padding(.leading, 56)
                                    }
                                }
                            }

                        }
                        .foregroundStyle(.white)
                        .padding(Guidelines.horizontalPadding)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))
                    }
                    .padding(Guidelines.horizontalPadding/2)
                    .background {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                    .fill(Color.black.opacity(0.5))
                            )
                            .blur(radius: 15)
                    }
                }
            }
        }
        .background(
            CustomImageView(
                url: recipe.image,
                width: .infinity,
                height: .infinity
            )
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    
                    
                    Menu {
                        Section{
                            Button("WhatsApp", systemImage: "phone.arrow.up.right") {
                                openWhatsApp()
                            }
                            
                            Button("SMS", systemImage: "ellipsis.message") {
                                openSMS()
                            }
                        }
                        
                        Section{
                            Button("Phone", systemImage: "phone") {
                                openPhoneDailer()
                            }

                            Button("Email", systemImage: "envelope") {
                                recipeDetailsViewModels.updateIsShowOpenShareSheet(value: true)
                            }
                        }

                    } label: {
                        Label("Contact Chef", systemImage: "phone.arrow.up.right")
                    }
                    
                    Divider()

                    Button {
                        Task { await shareRecipeAsPDF() }
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }

                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .task {
            recipeDetailsViewModels.recipe = recipe
            recipeDetailsViewModels.isInFavourite = await favouriteRecipesViewModel.checkIfIsInFavourites(
                recipe: recipe
            )
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $recipeDetailsViewModels.isShowOpenShareSheet) {
            ShareSheetView(
                activityItems: [
                    "I love your recipes, how about we grab a coffee sometime together and talk about cooking?"
                ]
            )
        }
        .overlay {
            Group {
                if recipeDetailsViewModels.isShowAlertDialog {
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
                else if recipeDetailsViewModels.isShowIngredientImageOverlay {
                    ImageOverlay(
                        image: recipeDetailsViewModels.ingredientImage ?? "",
                        imageWidth: .infinity,
                        imageHeight: 300,
                        onDismiss: {
                            recipeDetailsViewModels.updateIsShowIngredientImageOverlay(value: false)
                        }
                    )
                }
            }
        }
        .toastView(toast: $recipeDetailsViewModels.toast)
    }
    
    func statTile(icon: String, value: String, label: String) -> some View {
          VStack(spacing: 4) {
              
              Image(systemName: icon)
                  .font(.title3)

              Text(value)
                  .font(.system(.title, design: .rounded, weight: .bold))
              
              Text(label)
                  .font(.caption)
          }
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 16)
          .background(Color.white.opacity(0.2), in: RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous))
      }
    
    func onTapFollow(){
        recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
        recipeDetailsViewModels.updateDialogEntity(
            value: DialogEntity(
                title: "Coming soon.",
                message:
                    "Follow your favorite chefs to get notified about"
                    + "new recipes and exclusive offers is coming soon.",
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
    }

    func shareRecipeAsPDF() async {
        recipeDetailsViewModels.updateShareState(value: .isLoading)
        await ShareRecipeUtil.shared.shareRecipeAsPDF(
            recipe: recipe,
            onSuccess: {
                recipeDetailsViewModels.updateShareState(value: .good)
            },
            onError: { error in
                recipeDetailsViewModels.updateDialogEntity(
                    value: DialogEntity(
                        title: "Sharing Recipe Failed",
                        message: error,
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
            }
        )
    }

    func openWhatsApp() {
        if let phone = recipe.chef?.phoneComplete {
            ContactUtil.shared.openWhatsApp(
                phoneNumber: phone,
                message: "I love your recipes, how about we grab a coffee sometime together and talk about cooking?",
                onSuccess: {},
                onFailure: { error in
                    recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
                    recipeDetailsViewModels.updateDialogEntity(
                        value: DialogEntity(
                            title: "WhatsApp Error",
                            message: error,
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
                }
            )
        }
        else {
            recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
            recipeDetailsViewModels.updateDialogEntity(
                value: DialogEntity(
                    title: "No WhatsApp Number",
                    message: "The chef hasn't provided his/her WhatsApp number yet.",
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
        }
    }

    func openSMS() {
        if let phone = recipe.chef?.phoneComplete {
            ContactUtil.shared.openSMS(
                phoneNumber: phone,
                message: "I love your recipes, how about we grab a coffee sometime together and talk about cooking?",
                onSuccess: {},
                onFailure: { error in
                    recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
                    recipeDetailsViewModels.updateDialogEntity(
                        value: DialogEntity(
                            title: "SMS Error",
                            message: error,
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
                }
            )
        }
        else {
            recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
            recipeDetailsViewModels.updateDialogEntity(
                value: DialogEntity(
                    title: "No Phone Number",
                    message: "The chef hasn't provided his/her contact number yet.",
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
        }
    }

    func openPhoneDailer() {
        if let phone = recipe.chef?.phoneComplete {
            ContactUtil.shared.openSMS(
                phoneNumber: phone,
                message: "I love your recipes, how about we grab a coffee sometime together and talk about cooking?",
                onSuccess: {},
                onFailure: { error in
                    recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
                    recipeDetailsViewModels.updateDialogEntity(
                        value: DialogEntity(
                            title: "Phone Dialer Error",
                            message: error,
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
                }
            )
        }
        else {
            recipeDetailsViewModels.updateIsShowAlertDialog(value: true)
            recipeDetailsViewModels.updateDialogEntity(
                value: DialogEntity(
                    title: "No Phone Number",
                    message: "The chef hasn't provided his/her contact number yet.",
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
        }
    }
    
    func onTapDelete() async {
        if recipeDetailsViewModels.isInFavourite {
            isShowDeleteDialog = true
        }
        else {
            recipeDetailsViewModels.recipe?.isInFavorite = true
            await favouriteRecipesViewModel.addRecipeToFavourite(recipe: recipe)
            recipeDetailsViewModels.updateToast(
                value: Toast(
                    style: .success,
                    message: "\(recipe.name) added to favourites."
                )
            )
            os.Logger().log("DEBUG: Added to favourite")
        }
        recipeDetailsViewModels.isInFavourite =
            await favouriteRecipesViewModel.checkIfIsInFavourites(recipe: recipe)
    }
    
    func removeFromFavourites() async {
        await favouriteRecipesViewModel.deleteFavouriteRecipe(recipe: recipe)
        recipeDetailsViewModels.recipe?.isInFavorite = false
        recipeDetailsViewModels.updateToast(
            value: Toast(
                style: .warning,
                message: "\(recipe.name) removed from favourites."
            )
        )
        os.Logger().log("DEBUG: Removed from favourite")
    }

}

#Preview {
    if let recipe = RecipeModel.dummyList.first {
        NavigationStack{
            RecipeDetailsView(recipe: recipe)
                .environmentObject(Router())
        }
    }

}
