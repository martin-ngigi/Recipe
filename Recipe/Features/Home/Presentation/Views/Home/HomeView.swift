//
//  HomeView.swift
//  Recipe
//
//  Created by Martin on 13/03/2025.
//

import SwiftUI

struct HomeView: View {
    @State var searchField = ""
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var router: Router

    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                VStack{
                 
                    HStack{
                        Text("Discover Best \nRecipes")
                            .font(.custom(FontConstants.POPPINS_BOLD, size: 24))
                            .lineSpacing(0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.theme.grayColor1)
                    }
                    
                    // Search Bar
                    BorderedInputField(
                        text: $searchField,
                        placeholder: "Search recipes...",
                        error: "",
                        onTextChange: { text in
                            
                        }
                    )
                    
                    JustForYouSliderView(
                        recipes: homeViewModel.justForYouList,
                        onTap: { recipe in
                            router.push(.recipedetails(recipe: recipe))
                        }
                    )

                    
                    // Trending Recipes
                    TrendingRecipesHome(
                        columns: columns,
                        recipes: homeViewModel.trendingRecipesList,
                        onTapRecipe: { recipeModel in
                             router.push(.recipedetails(recipe: recipeModel))
                        },
                        onTapSeeAll: {
                            router.push(.trendingRecipes(list: homeViewModel.trendingRecipesList))
                        }
                    )
                    .padding(.top, 10)
                    
                    PopularChefsComponent(
                        chefs: homeViewModel.popularChefsList,
                        onTapChef: { chef in
                            router.push(.chefdetails(chef: chef))
                        },
                        onTapSeeAll: {
                            router.push(.popularChefs(list:  homeViewModel.popularChefsList))
                        }
                    )
                    .padding(.top, 10)
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Dismiss") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
            .refreshable {
                Task {
                    await homeViewModel.fetchHomeData(
                         onSuccess: { homeResponseModel in
                             
                         },
                         onFailure: { error in
                             homeViewModel.updateIsShowInbuiltAlert(value: true)
                             homeViewModel.updateInbuiltAlert(
                                 value: InbuiltAlert(
                                     title: "Something went wrong!",
                                     message: error
                                 )
                             )
                         }
                     )
                }
            }
            .task {
               await homeViewModel.fetchHomeData(
                    onSuccess: { homeResponseModel in
                        
                    },
                    onFailure: { error in
                        homeViewModel.updateIsShowInbuiltAlert(value: true)
                        homeViewModel.updateInbuiltAlert(
                            value: InbuiltAlert(
                                title: "Something went wrong!",
                                message: error
                            )
                        )
                    }
                )
            }
        }
        .alert(isPresented: $homeViewModel.isShowInbuiltAlert){
            Alert(
                title: Text(homeViewModel.inbuiltAlert?.title ?? ""),
                message: Text(homeViewModel.inbuiltAlert?.message ?? ""),
                primaryButton: .destructive(Text("Retry")) {
                    Task{
                        await homeViewModel.fetchHomeData(
                             onSuccess: { homeResponseModel in
                                 
                             },
                             onFailure: { error in
                                 homeViewModel.updateIsShowInbuiltAlert(value: true)
                                 homeViewModel.updateInbuiltAlert(
                                     value: InbuiltAlert(
                                         title: "Something went wrong!",
                                         message: error
                                     )
                                 )
                             }
                         )
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .fullScreenProgressOverlay(isShowing: homeViewModel.fetchHomeDataState == .isLoading)
        //.hideBottomNavigationBar(false)
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())

}
