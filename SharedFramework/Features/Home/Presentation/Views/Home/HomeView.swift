/*
* Created by Martin Wainaina on 16/08/2026
*
* Feel free to contribute.
*/

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
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                Label("Desert", systemImage: "sun.max.fill")
                    .padding()
                    .glassEffect(.regular.interactive())
                
                VStack {

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
            .navigationTitle("Recipe Picks")
            .navigationSubtitle("Discover best recipes")
            .padding(.horizontal)
            .searchable(
                text: $homeViewModel.searchField,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search recipes..."
            )
            .scrollEdgeEffectStyle(.soft, for: .top)
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
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        tabRouter.selectedTab = .profile
                    } label: {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color.gray)

                    }
                    .accessibilityLabel("Profile")
                }
                .sharedBackgroundVisibility(.hidden)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        router.push(.notifications)
                    } label: {
                       Image(systemName: "bell.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color.gray)
                    }
                    .accessibilityLabel("Notifications")
                    .badge(2)
                }

            }
            .refreshable {
                Task {
                    await fetchHomeData()
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
                primaryButton: .default(Text("Retry")) {
                    Task { await fetchHomeData() }
                },
                secondaryButton: .cancel()
            )
        }
        .fullScreenProgressOverlay(isShowing: homeViewModel.fetchHomeDataState == .isLoading)
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
