//
//  HomeView.swift
//  Recipe
//
//  Created by Martin on 13/03/2025.
//

import SwiftUI

struct HomeView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var router: Router
    @EnvironmentObject var tabRouter: TabRouter

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {

                VStack {

                    HStack {
                        Text("Discover Best \nRecipes")
                            .font(.custom(FontConstants.POPPINS_BOLD, size: 24))
                            .lineSpacing(0)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        Button {
                            tabRouter.selectedTab = .profile
                        } label: {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.theme.grayColor1)
                        }
                    }

                    // Search Bar
                    BorderedInputField(
                        text: $homeViewModel.searchField,
                        placeholder: "Search recipes...",
                        error: "",
                        onTextChange: { _ in

                        }
                    )

                    JustForYouSliderView(
                        recipes: homeViewModel.justForYouList,
                        isLoading: homeViewModel.fetchHomeDataState == .isLoading,
                        currentIndex: homeViewModel.currentIndex,
                        onTap: { recipe in
                            router.push(.recipedetails(recipe: recipe))
                        },
                        onUpdateCurrentIndex: { currentIndex in
                            homeViewModel.currentIndex = currentIndex
                        }
                    )

                    // Trending Recipes
                    TrendingRecipesHome(
                        columns: columns,
                        recipes: homeViewModel.trendingRecipesList,
                        isLoading: homeViewModel.fetchHomeDataState == .isLoading,
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
                        isLoading: homeViewModel.fetchHomeDataState == .isLoading,
                        onTapChef: { chef in
                            router.push(.chefdetails(chef: chef))
                        },
                        onTapSeeAll: {
                            router.push(.popularChefs(list: homeViewModel.popularChefsList))
                        }
                    )
                    .padding(.top, 10)

                }
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Dismiss") {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    }
                }
            }
            .refreshable {
                Task {
                    await homeViewModel.fetchHomeData(
                        onSuccess: { _ in

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
                await fetchHomeData()
            }
        }
        .alert(isPresented: $homeViewModel.isShowInbuiltAlert) {
            Alert(
                title: Text(homeViewModel.inbuiltAlert?.title ?? ""),
                message: Text(homeViewModel.inbuiltAlert?.message ?? ""),
                primaryButton: .destructive(Text("Retry")) {
                    Task {
                        await homeViewModel.fetchHomeData(
                            onSuccess: { _ in

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
        .hideBottomNavigationBar(false)

        .overlay {
            HomeSearchOverlay(
                searchField: $homeViewModel.searchField,
                isShowSearchResults: .constant(!homeViewModel.searchField.isEmpty),
                recipePage: $homeViewModel.recipePage,
                chefPage: $homeViewModel.chefPage,
                isLoading: homeViewModel.searchState == .isLoading,
                onSearchTextChange: { _ in
                    Task {
                        await homeViewModel.searchAll(
                            searchText: homeViewModel.searchField,
                            onSuccess: { searchResponseModel in
                                homeViewModel.searchRecipes = searchResponseModel.recipes
                                homeViewModel.searchChefs = searchResponseModel.chefs
                            },
                            onFailure: { _ in

                            }
                        )
                    }
                },
                recipes: homeViewModel.searchRecipes,
                chefs: homeViewModel.searchChefs,
                onTapRecipe: { recipe in
                    router.push(.recipedetails(recipe: recipe))
                },
                onTapChef: { chef in
                    router.push(.chefdetails(chef: chef))
                }
            )
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
        }

    }

    func fetchHomeData() async {
        await homeViewModel.fetchHomeData(
            onSuccess: { _ in

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

#Preview {
    HomeView()
        .environmentObject(Router())
        .environmentObject(TabRouter())

}
