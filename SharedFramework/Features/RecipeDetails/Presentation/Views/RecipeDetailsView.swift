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
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let recipe = recipeDetailsViewModels.recipe {
                VStack(spacing: 8) {
                    
                    Spacer(minLength: UIScreen.main.bounds.height * 0.4)
                    
                    VStack{
                        
                        // Chef Banner
                        Button {
                            if let chef = recipe.chef {
                                router.push(.chefdetails(chef: chef))
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 16) {
                                
                                CustomImageView(
                                    url: recipe.chef?.avatarName ?? "",
                                    width: 64,
                                    height: 64
                                )
                                .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 4) {

                                    Text(recipe.chef?.name ?? "")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)

                                    Text("View Profile & Recipes")
                                        .font(.callout)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .imageScale(.small)
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(Guidelines.horizontalPadding)
                        .background {
                            RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                .fill(.thinMaterial)
                                .overlay {
                                    RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                        .fill(
                                            colorScheme == .dark
                                            ? Color.black.opacity(0.40)
                                            : Color.white.opacity(0.55)
                                        )
                                }
                        }
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))

                        // Title and description
                        VStack(alignment: .leading, spacing: 32) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(recipe.name)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)

                                    Spacer()
                                }
                                
                                Text(recipe.description)
                                    .font(.callout)
                                    .foregroundColor(.primary)
                            }
                            
                            HStack(spacing: 8) {
                                statTile(icon: "list.bullet", value: "\(recipe.ingredients.count)", label: "Ingredients")
                                statTile(icon: "checklist", value: "\(recipe.inststuctionsList.count)", label: "Instructions")
                            }
                        }
                        .padding(Guidelines.horizontalPadding)
                        .background {
                            RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                .fill(.thinMaterial)
                                .overlay {
                                    RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                        .fill(
                                            colorScheme == .dark
                                            ? Color.black.opacity(0.40)
                                            : Color.white.opacity(0.55)
                                        )
                                }
                        }
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))
                        
                        // Ingredients
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .lastTextBaseline ,spacing: 4) {
                                Text("Ingredients")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)

                                Text("(\(recipe.ingredients.count))")
                                    .font(.callout)
                                    .foregroundColor(.secondary)

                                Spacer()

                            }
                            
                            VStack(spacing: 8) {
                                if recipe.ingredients.count > 3 {
                                    VStack(spacing: 8) {

                                        let recipes = recipe.ingredients.prefix(recipeDetailsViewModels.isShowAllItems ? recipe.ingredients.count : 3 )
                                        
                                        ForEach(Array(recipes.enumerated()), id: \.offset) { index, ingredient in
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
                                            .padding(.vertical, 8)

                                            if index < recipes.count - 1 {
                                                Divider()
                                                    .foregroundColor(.secondary)
                                                    .padding(.leading, 80)
                                            }
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            Text(
                                                recipeDetailsViewModels.isShowAllItems
                                                    ? "...show less" : "...\(recipe.ingredients.count - 3) more items"
                                            )
                                            .font(.body)
                                            .foregroundColor(Color.theme.primaryColor)
                                            .onTapGesture {
                                                recipeDetailsViewModels.isShowAllItems.toggle()
                                            }
                                        }
                                    }
                                }
                                else {
                                    ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in

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
                        .padding(Guidelines.horizontalPadding)
                        .background {
                            RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                .fill(.thinMaterial)
                                .overlay {
                                    RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                        .fill(
                                            colorScheme == .dark
                                            ? Color.black.opacity(0.40)
                                            : Color.white.opacity(0.55)
                                        )
                                }
                        }
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .lastTextBaseline ,spacing: 4) {
                                Text("Instructions")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)

                                Text("(\(recipe.inststuctionsList.count))")
                                    .font(.callout)
                                    .foregroundColor(.secondary)

                                Spacer()

                            }
                            
                            VStack(spacing: 8) {
                                ForEach(Array(recipe.inststuctionsList.enumerated()), id: \.offset) { index, instruction in
                                    
                                    HStack(alignment: .top, spacing: 16) {
                                        Text("\(index + 1)")
                                            .font(.subheadline.weight(.bold))
                                            .foregroundStyle(.white)
                                            .padding(12)
                                            .background(Color.primary.opacity(0.2), in: Circle())
                                        
                                        Text(instruction)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                            .lineSpacing(4)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.top, 2)
                                    }
                                    .padding(.vertical, 8)
                                    
                                    if index < recipe.inststuctionsList.count - 1 {
                                        Divider()
                                            .foregroundColor(.secondary)
                                            .padding(.leading, 48)
                                    }
                                }
                            }

                        }
                        .foregroundStyle(.white)
                        .padding(Guidelines.horizontalPadding)
                        .background {
                            RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                .fill(.thinMaterial)
                                .overlay {
                                    RoundedRectangle(cornerRadius: Guidelines.cornerRadius, style: .continuous)
                                        .fill(
                                            colorScheme == .dark
                                            ? Color.black.opacity(0.40)
                                            : Color.white.opacity(0.55)
                                        )
                                }
                        }
                        .clipShape(.rect(cornerRadius: Guidelines.cornerRadius))
                    }
                    .padding(Guidelines.horizontalPadding/2)
                }
            }
        }
        .background(
            CustomImageView(
                url: recipe.image,
                width: .infinity,
                height: .infinity
            )
            .ignoresSafeArea()
        )
        .toolbar {
            
            ToolbarSpacer(.flexible)
                        
            ToolbarItemGroup {
                Button {
                    Task { await onTapFavourite()  }
                } label: {
                    if favouriteRecipesViewModel.fetchFavouriteState == .isLoading {
                        ProgressView()
                    }
                    else {
                        let isInFavourite = recipeDetailsViewModels.recipe?.isInFavorite ?? false
                        Label(isInFavourite  ? "Unfavorite" : "Favorite", systemImage: "heart")
                            .symbolVariant(isInFavourite  ? .fill : .none)
                    }
                }
                .confirmationDialog("Remove from favourites", isPresented: $isShowDeleteDialog) {
                    Button("Remove", role: .destructive){
                        Task{ await removeFromFavourites() }
                    }
                } message: {
                    Text("Are you sure you wish to remove \(recipe.name) from favourites ?")
                }
                
                //ShareLink(item: recipe, preview: recipe.sharePreview)
                Button {
                    Task { await shareRecipeAsPDF() }
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            
            ToolbarSpacer(.fixed)
            
            ToolbarItem {
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
            let _ = await favouriteRecipesViewModel.checkIfIsInFavourites(
                recipe: recipe
            )
        }
        .ignoresSafeArea()
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
        .overlay {
            CustomPushNotificationView(
                data: recipeDetailsViewModels.states.popNotificationData,
                isPresented: $recipeDetailsViewModels.states.isPopNotificationPresented
            )
        }
    }
    
    func statTile( icon: String, value: String, label: String) -> some View {

        HStack(alignment: .bottom, spacing: 16) {
            Text(value)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .scaleEffect(52 / UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
                .foregroundStyle(.primary)

            VStack(alignment: .leading, spacing: 2) {
                Image(systemName: icon)
                    .font(.callout)

                Text(label)
                    .font(.callout)
            }
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .padding(.vertical, 32)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(
                cornerRadius: Guidelines.cornerRadius,
                style: .continuous
            )
            .fill(.regularMaterial)
            .overlay {
                RoundedRectangle(
                    cornerRadius: Guidelines.cornerRadius,
                    style: .continuous
                )
                .stroke(
                    Color.white.opacity(colorScheme == .dark ? 0.12 : 0.45),
                    lineWidth: 0.5
                )
            }
        }
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
    
    func onTapFavourite() async {
        if recipeDetailsViewModels.recipe?.isInFavorite ?? false {
            isShowDeleteDialog = true
        }
        else {
            recipeDetailsViewModels.recipe?.isInFavorite = true
            await favouriteRecipesViewModel.addRecipeToFavourite(recipe: recipe)
            recipeDetailsViewModels.updatePopNotificationData(
                data: PopNotificationData(
                    title: "Marked as favourite.",
                    message:  "\(recipe.name) has been added to favourites.",
                    type: .success
                ),
                isPresented: true
            )
            
            os.Logger().log("DEBUG: Added to favourite")
        }
    }
    
    func removeFromFavourites() async {
        await favouriteRecipesViewModel.deleteFavouriteRecipe(recipe: recipe)
        recipeDetailsViewModels.recipe?.isInFavorite = false
        recipeDetailsViewModels.updatePopNotificationData(
            data: PopNotificationData(
                title: "Unmarked as favourite.",
                message: "\(recipe.name) removed from favourites.",
                type: .success
            ),
            isPresented: true
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
