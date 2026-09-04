/*
* Created by Martin Wainaina on 26/08/2026
*
* Feel free to contribute.
*/

//
//  ChefDetailsView.swift
//  Recipe
//
//  Created by Hummingbird on 04/07/2025.
//

import SwiftUI


struct ChefDetailsView: View {
    @StateObject var chefViewModel = ChefViewModel()
    @StateObject var rateViewModel = RateViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    var chef: UserModel
    var user: UserModel?
    @EnvironmentObject var tabRouter: TabRouter
    @EnvironmentObject var router: Router
    private let horizontalMargins = 16.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                HStack(spacing: 16) {
                    var avatar: String {
                        if "\(chefViewModel.chef?.avatar ?? "")".starts(with: "http") {
                            return chefViewModel.chef?.avatar ?? ""
                        }
                        else {
                            return "\(Constants.BASE_URL)\(chef.avatar)"
                        }
                    }

                    Button {
                        withAnimation(.spring()) {
                            chefViewModel.updateIsShowChefImageOverlay(value: true)
                        }
                    } label: {
                        CustomImageView(
                            url: avatar,
                            maxWidth: 80,
                            height: 80
                        )
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.secondary, lineWidth: 1))
                        .foregroundColor(Color.theme.blackAndWhite)
                    }

                    VStack(alignment: .leading) {
                        Text(chefViewModel.chef?.name ?? "")
                            .font(.title2.bold())
                        Text(chefViewModel.chef?.email ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        HStack {
                            Text("\(chefViewModel.chef?.rate?.ratingFormatted ?? "0.0") ⭐️")
                                .foregroundColor(Color.orange)

                            Spacer()

                            Button {
                                if let user = chefViewModel.user {
                                    chefViewModel.isShowRating = true
                                }
                                else {
                                    chefViewModel.updateIsShowAlertDialog(value: true)
                                    chefViewModel.updateDialogEntity(
                                        value: DialogEntity(
                                            title: "Login Required",
                                            message: "You need to login to rate a chef. Do you want to login now?",
                                            icon: "",
                                            confirmButtonText: "Preceed",
                                            dismissButtonText: "Cancel",
                                            onConfirm: {
                                                chefViewModel.updateIsShowAlertDialog(value: false)
                                                router.popToRoot()
                                                tabRouter.selectedTab = .profile
                                            },
                                            onDismiss: {
                                                chefViewModel.updateIsShowAlertDialog(value: false)
                                            }
                                        )
                                    )
                                }
                            } label: {
                                Text("Rate Me")
                                    .foregroundColor(.gray)
                                    .underline()
                            }
                        }
                        .font(.subheadline)
                        .padding(.top, 10)
                    }

                    Spacer()
                }
                .padding(.horizontal, horizontalMargins)

                Divider()
                    .padding(.horizontal, horizontalMargins)
                
                // MARK: - Most Liked Recipes Section
                if let mostLikedRecipes = chefViewModel.chef?.recipesList {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Most Liked Recipes")
                            .font(.title3.bold())
                            .padding(.horizontal, horizontalMargins)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(mostLikedRecipes, id: \.recipeId) { recipe in
                                    MostLikedRecipesCard(recipe: recipe)
                                        .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                            content
                                                .scaleEffect(1.0 - 0.12 * abs(phase.value))
                                        }
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .contentMargins(.horizontal, horizontalMargins, for: .scrollContent)
                        .scrollTargetBehavior(.viewAligned)
                    }
                }
                
                // MARK: - All Recipes Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("All Recipes")
                        .font(.title3.bold())

                    if let recipesList = chefViewModel.chef?.recipesList {
                        if recipesList.count > 1 {
                            VStack(spacing: 2) {
                                ForEach(
                                    recipesList.prefix(chefViewModel.isShowAllRecipeItems ? recipesList.count : 1),
                                    id: \.self
                                ) { recipe in
                                    RecipeCard(
                                        recipe: recipe,
                                        onTap: { _ in

                                        }
                                    )
                                }

                                HStack {
                                    Spacer()
                                    Text(
                                        chefViewModel.isShowAllRecipeItems
                                            ? "...show less" : "...\(recipesList.count - 1) more items"
                                    )
                                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                                    .foregroundColor(Color.theme.primaryColor)
                                    .padding(.vertical)
                                    .onTapGesture {
                                        chefViewModel.isShowAllRecipeItems.toggle()
                                    }
                                }
                            }
                        }
                        else {
                            ForEach(recipesList, id: \.self) { recipe in
                                VStack(spacing: 10) {
                                    RecipeCard(
                                        recipe: recipe,
                                        onTap: { _ in

                                        }
                                    )
                                }
                            }
                        }

                    }
                }
                .padding(.horizontal, horizontalMargins)

                Divider()
                    .padding(.horizontal, horizontalMargins)

                // MARK: - Ratings Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ratings & Reviews")
                        .font(.title3.bold())

                    ForEach(chefViewModel.chef?.allRates ?? [], id: \.rateID) { rating in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(rating.rater.name)
                                    .font(.headline)
                                Spacer()
                                Text("⭐️ \(String(format: "%.1f", rating.rating))")
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                            }
                            Text(rating.comment)
                                .font(.body)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }

                }
                .padding(.horizontal, horizontalMargins)
            }
            .task {
                await chefViewModel.fetchChefByID(
                    chefId: chef.openID,
                    onSuccess: { chef in
                        chefViewModel.updateChef(chef: chef)
                    },
                    onFailure: { _ in
                        chefViewModel.updateChef(chef: nil)
                    }
                )

            }
        }
        .onAppear {
            let user = loginViewModel.fetchUserFromLocalStorage()
            chefViewModel.updateUser(user: user)
        }
        .overlay {
            Group {
                if chefViewModel.isShowRating {
                    RatingView(
                        rating: $chefViewModel.rating,
                        comment: $chefViewModel.comment,
                        onDismiss: {
                            chefViewModel.isShowRating = false
                        },
                        onSubmit: { rate, comment in
                            Task {

                                await rateViewModel.createUpdateRate(
                                    createRateRequestModel: CreateRateRequestModel(
                                        raterID: user?.openID ?? "",
                                        rateeID: chef.openID,
                                        rating: rate,
                                        comment: comment
                                    ),
                                    onSuccess: { createRateResponseModel in
                                        chefViewModel.isShowRating = false
                                        chefViewModel.chef?.allRates = createRateResponseModel.data.ratings
                                        chefViewModel.chef?.rate = createRateResponseModel.data.totalRate
                                    },
                                    onFailure: { error in

                                        chefViewModel.isShowRating = false

                                        chefViewModel.updateIsShowAlertDialog(value: true)
                                        chefViewModel.updateDialogEntity(
                                            value: DialogEntity(
                                                title: "Error occurred",
                                                message: error,
                                                icon: "",
                                                confirmButtonText: "Cancel",
                                                dismissButtonText: "Okay",
                                                onConfirm: {
                                                    chefViewModel.updateIsShowAlertDialog(value: false)
                                                },
                                                onDismiss: {
                                                    chefViewModel.updateIsShowAlertDialog(value: false)
                                                }
                                            )
                                        )

                                    }
                                )

                            }
                        }
                    )
                }
                else if chefViewModel.isShowAlertDialog {
                    CustomAlertDialog(
                        isPresented: $chefViewModel.isShowAlertDialog,
                        title: chefViewModel.dialogEntity.title,
                        text: chefViewModel.dialogEntity.message,
                        confirmButtonText: chefViewModel.dialogEntity.confirmButtonText,
                        dismissButtonText: chefViewModel.dialogEntity.dismissButtonText,
                        imageName: chefViewModel.dialogEntity.icon,
                        onDismiss: {
                            if let onDismiss = chefViewModel.dialogEntity.onDismiss {
                                onDismiss()
                            }
                        },
                        onConfirmation: {
                            if let onConfirm = chefViewModel.dialogEntity.onConfirm {
                                onConfirm()
                            }
                        }
                    )
                }
                else if chefViewModel.isShowChefImageOverlay {
                    var avatar: String {
                        if chef.avatar.starts(with: "http") {
                            return chef.avatar
                        }
                        else {
                            return "\(Constants.BASE_URL)\(chefViewModel.chef?.avatar ?? "")"
                        }
                    }

                    ImageOverlay(
                        image: avatar,
                        imageWidth: .infinity,
                        imageHeight: 300,
                        onDismiss: {
                            chefViewModel.updateIsShowChefImageOverlay(value: false)
                        }
                    )
                }
            }
        }
        .navigationTitle("Chef Details")
    }
}
#Preview {
    if let chef = UserModel.dummyChefResoinse?.data {
        NavigationStack {
            ChefDetailsView(chef: chef)
                .environmentObject(Router())
                .environmentObject(TabRouter())
        }
    }
}
