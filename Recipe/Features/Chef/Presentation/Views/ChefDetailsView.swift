//
//  ChefDetailsView.swift
//  Recipe
//
//  Created by Hummingbird on 04/07/2025.
//

import SwiftUI

struct ChefDetailsView: View {
    @StateObject var chefViewModel =  ChefViewModel()
    @StateObject var rateViewModel =  RateViewModel()
    @StateObject var loginViewModel =  LoginViewModel()
    @State var isShowAllRecipeItems = false
    @State var chef: UserModel
    @State var user: UserModel?
    @EnvironmentObject var tabRouter: TabRouter
    @EnvironmentObject var router: Router

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(spacing: 16) {
                    var avatar: String{
                        if chef.avatar.starts(with: "http"){
                            return chef.avatar
                        }
                        else {
                            return "\(Constants.BASE_URL)\(chef.avatar)"
                        }
                    }
                    
                    Button{
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
                        Text(chef.name)
                            .font(.title2.bold())
                        Text(chef.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack{
                            Text("\(chef.rate?.ratingFormatted ?? "0.0") ⭐️")
                                .foregroundColor(Color.orange)
                            
                            Spacer()
                            
                            Button{
                                if let user = user {
                                    chefViewModel.isShowRating = true
                                }
                                else {
                                    chefViewModel.updateIsShowAlertDialog(value: true)
                                     chefViewModel.updateDialogEntity(
                                        value:  DialogEntity(
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

                Divider()

                // MARK: - Recipes Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recipes")
                        .font(.title3.bold())
                    
                    if let recipesList = chef.recipesList{
                        if recipesList.count > 1{
                            VStack(spacing: 2) {
                                ForEach(recipesList.prefix(isShowAllRecipeItems ? recipesList.count :  1), id: \.self) { recipe in
                                    RecipeCard(
                                        recipe: recipe,
                                        onTap: { recipe in
                                            
                                        }
                                    )
                                }
                                
                                HStack {
                                    Spacer()
                                    Text(isShowAllRecipeItems ? "...show less" : "...\(recipesList.count - 1) more items")
                                        .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                                        .foregroundColor(Color.theme.primaryColor)
                                        .padding(.vertical)
                                        .onTapGesture {
                                            isShowAllRecipeItems.toggle()
                                        }
                                }
                            }
                        }
                        else {
                            ForEach(recipesList, id: \.self) { recipe in
                                VStack(spacing: 10) {
                                    RecipeCard(
                                        recipe: recipe,
                                        onTap: { recipe in
                                            
                                        }
                                    )
                                }
                            }
                        }
                        
                    }
                }

                Divider()

                // MARK: - Ratings Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ratings & Reviews")
                        .font(.title3.bold())

                    ForEach(chef.allRates ?? [], id: \.rateID) { rating in
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
            }
            .task{
                await chefViewModel.fetchChefByID(
                    chefId: chef.openID,
                    onSuccess: { chef in
                        self.chef = chef
                    },
                    onFailure: { error in
                        
                    }
                )
                
            }
            .padding()
        }
        .onAppear{
            user = loginViewModel.fetchUserFromLocalStorage()
        }
        .overlay{
            Group{
                if chefViewModel.isShowRating {
                    RatingView(
                        onDismiss: {
                            chefViewModel.isShowRating = false
                        },
                        onSubmit: { rate, comment in
                            Task{
                                
                                await rateViewModel.createUpdateRate(
                                    createRateRequestModel: CreateRateRequestModel(
                                        raterID: user?.openID ?? "",
                                        rateeID: chef.openID ,
                                        rating: rate,
                                        comment: comment
                                    ),
                                    onSuccess: { createRateResponseModel in
                                        chefViewModel.isShowRating = false
                                        chef.allRates = createRateResponseModel.data.ratings
                                        chef.rate = createRateResponseModel.data.totalRate
                                    },
                                    onFailure: { error in
                                       
                                        chefViewModel.isShowRating = false
                                        
                                        chefViewModel.updateIsShowAlertDialog(value: true)
                                        chefViewModel.updateDialogEntity(
                                            value:  DialogEntity(
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
                else if chefViewModel.isShowAlertDialog{
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
                else if chefViewModel.isShowChefImageOverlay{
                    var avatar: String{
                        if chef.avatar.starts(with: "http"){
                            return chef.avatar
                        }
                        else {
                            return "\(Constants.BASE_URL)\(chef.avatar)"
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
        NavigationStack{
            ChefDetailsView(chef: chef)
                .environmentObject(Router())
                .environmentObject(TabRouter())
        }
    }
}
