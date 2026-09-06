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
//    let columnss = [GridItem(.adaptive(minimum: 72, maximum: 100), spacing: 12, alignment: .top)]
//    let columns2 = [GridItem(.adaptive(minimum: 72, maximum: 100), spacing: 12, alignment: .top)]
//    let columns3 = [ GridItem(.adaptive(minimum: 72), spacing: 8, alignment: .top)]
    let columns4 = Array( repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 2)

    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var router: Router
    @EnvironmentObject var tabRouter: TabRouter
    @Namespace private var namespace
    let horizontalMargins = 16.0

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
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
                    .padding(.horizontal, horizontalMargins)
                   
                    VStack(alignment: .leading, spacing: 16){
                        
                        var noRecipes: Bool {
                            return homeViewModel.trendingRecipesList.isEmpty && homeViewModel.fetchHomeDataState != .isLoading
                        }
                        
                        HStack {
                            
                            Text("Trending Recipes")
                                .font(.headline)

                            Spacer()

                            if !noRecipes {
                                Button {
                                    router.push(.trendingRecipes(list: homeViewModel.trendingRecipesList))
                                } label: {
                                    HStack(spacing: 4) {
                                        Text("See All")
                                            .font(.footnote)

                                        Image(systemName: "chevron.right")
                                            .imageScale(.small)

                                    }
                                    .foregroundStyle(.primary)
                                }
                                .accessibilityLabel("See all trending recipes")
                            }

                        }
                        .padding(.horizontal, horizontalMargins)
                        
                        if noRecipes {
                            EmptyScreenView(
                                imageName: "tray",
                                imageSize: 80,
                                title: "Trending",
                                titleSize: 18,
                                description: """
                                    No trending recipes found.
                                    """,
                                descriptionSize: 12
                            )
                            .padding(.horizontal, horizontalMargins)
                        }
                        else {
                            ScrollView(.horizontal){
                                LazyVGrid(columns: columns4, spacing: 16) {
                                    ForEach(homeViewModel.trendingRecipesList, id: \.self) { recipe in
                                        NavigationLink {
                                            RecipeDetailsView(recipe: recipe)
                                                .navigationTransition(.zoom(sourceID: recipe.recipeId, in: namespace))
                                        } label: {
                                            RecipeItemView(recipe: recipe)
                                                .matchedTransitionSource(id: recipe.recipeId, in: namespace)
                                        }
                                    }
                                }
                            }
                            .contentMargins(.horizontal, horizontalMargins)
                        }
                    }

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
                    .padding(.horizontal, horizontalMargins)

                }
            }
            .navigationTitle("Recipe Picks")
            .navigationSubtitle("Discover best recipes")
            .searchable(
                text: $homeViewModel.searchField,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search recipes"
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
