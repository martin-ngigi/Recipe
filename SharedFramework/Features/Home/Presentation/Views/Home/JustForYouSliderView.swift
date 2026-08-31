/*
* Created by Martin Wainaina on 16/08/2026
*
* Feel free to contribute.
*/

//
//  JustForYouSliderView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI
import Combine

struct JustForYouSliderView: View {
    var recipes: [RecipeModel]
    var isLoading: Bool = false
    var currentIndex: Int = 0
    var onTap: (RecipeModel) -> Void
    var onUpdateCurrentIndex: (Int) -> Void
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 8) {
            Text("Just For You")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            if recipes.isEmpty && isLoading == false {
                EmptyScreenView(
                    imageName: "tray",
                    imageSize: 80,
                    title: "Recommendations",
                    titleSize: 18,
                    description: """
                        No recommendations found.
                        """,
                    descriptionSize: 12
                )
            }
            else {
                TabView(selection: .constant(currentIndex)) {
                    ForEach(0..<recipes.count, id: \.self) { index in
                        ZStack {
                            Button {
                                onTap(recipes[index])
                            } label: {
                                CustomImageView(
                                    url: recipes[index].image,
                                    maxWidth: .infinity,
                                    height: 240
                                )
                                .foregroundColor(Color.theme.blackAndWhite)
                                .clipped()
                                .cornerRadius(24)
                                .contentShape(Rectangle())
                                .overlay(alignment: .bottom) {
                                    VStack(spacing: 0){
                                        Text("\(recipes[index].name)")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)

                                        Text("\(recipes[index].chef?.name ?? "")")
                                            .font(.footnote)
                                            .foregroundColor(.white)

                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 32)//72
                                    .padding(.horizontal)
                                    .background(
                                        LinearGradient(
                                            colors: [
                                                Color.black.opacity(0.05),
                                                Color.black.opacity(0.075),
                                                Color.black.opacity(0.1),
                                                Color.black.opacity(0.15),
                                                Color.black.opacity(0.2)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                }
                            }

                        }
                        .tag(index)
                    }
                }
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .onReceive(timer) { _ in
                    guard !reduceMotion else { return }
                    withAnimation {
                        if !recipes.isEmpty {
                            onUpdateCurrentIndex((currentIndex + 1) % recipes.count)
                        }
                    }
                }
            }

        }
        .padding(.top, 10)
    }
}

#Preview {
    JustForYouSliderView(
        recipes: RecipeModel.dummyList,
        onTap: { _ in

        },
        onUpdateCurrentIndex: { _ in

        }
    )
    .padding()
}
