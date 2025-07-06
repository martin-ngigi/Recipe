//
//  ChefDetailsView.swift
//  Recipe
//
//  Created by Hummingbird on 04/07/2025.
//

import SwiftUI

struct ChefDetailsView: View {
    @StateObject var chefViewModel =  ChefViewModel()
    @State var chef: ChefModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(spacing: 16) {
                    CustomImageView(
                        url: chef.avatar,
                        maxWidth: 80,
                        height: 80
                    )
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.secondary, lineWidth: 1))

                    VStack(alignment: .leading) {
                        Text(chef.name)
                            .font(.title2.bold())
                        Text(chef.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding(.horizontal)

                Divider()

                // MARK: - Recipes Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recipes")
                        .font(.title3.bold())
                        .padding(.horizontal)

                    ForEach(chef.recipesList ?? [], id: \.self) { recipe in
                        RecipeCard(recipe: recipe)
                    }
                }

                Divider()

                // MARK: - Ratings Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ratings & Reviews")
                        .font(.title3.bold())
                        .padding(.horizontal)

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
                        .padding(.horizontal)
                    }
                    
                }
            }
            .task{
                await chefViewModel.fetchChefByID(
                    chefId: chef.openId,
                    onSuccess: { chef in
                        self.chef = chef
                    },
                    onFailure: { error in
                        
                    }
                )
            }
            .padding(.vertical)
        }
        .navigationTitle("Chef Details")
    }
}
