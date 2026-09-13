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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack(spacing: 16) {
            Text("Just For You")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Guidelines.horizontalPadding)

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
                Group{
                    if horizontalSizeClass == .regular {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(0..<recipes.count, id: \.self) { index in
                                    Button {
                                        onTap(recipes[index])
                                    } label: {
                                        JustForYouSliderItem(
                                            image: recipes[index].image,
                                            recipeName: recipes[index].name,
                                            chefName: recipes[index].chef?.name ?? ""
                                        )
                                        .frame(minWidth: 360)
                                        .frame(height: 240)
                                    }
                                    .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                        content
                                            .scaleEffect(1.0 - 0.12 * abs(phase.value))
                                    }
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .contentMargins(.horizontal, Guidelines.horizontalPadding, for: .scrollContent)
                        .scrollTargetBehavior(.viewAligned)
                    }
                    else{
                        TabView(selection: .constant(currentIndex)) {
                            ForEach(0..<recipes.count, id: \.self) { index in
                                ZStack {
                                    Button {
                                        onTap(recipes[index])
                                    } label: {
                                        JustForYouSliderItem(
                                            image: recipes[index].image,
                                            recipeName: recipes[index].name,
                                            chefName: recipes[index].chef?.name ?? ""
                                        )
                                    }
                                }
                                .tag(index)
                            }
                        }
                        .frame(height: 240)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .clipShape(RoundedRectangle(cornerRadius: Guidelines.cornerRadius))
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
            }
        }
        .padding(.top, 10)
    }
}

struct JustForYouSliderItem: View {
    
    var image: String
    var recipeName: String
    var chefName: String
    
    var body: some View{
        CustomImageView(
            url: image,
            maxWidth: .infinity,
            height: 240
        )
        .foregroundColor(Color.theme.blackAndWhite)
        .clipped()
        .contentShape(Rectangle())
        .overlay(alignment: .bottom) {
            VStack(spacing: 0){
                Text(recipeName)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text(chefName)
                    .font(.footnote)
                    .foregroundColor(.white)

            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 48)
            .padding(.horizontal)
            .background(
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.1),
                        Color.black.opacity(0.25),
                        Color.black.opacity(0.5),
                        Color.black.opacity(0.75),
                        Color.black.opacity(0.75),
                        Color.black.opacity(1),
                        Color.black.opacity(1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .clipShape(.rect(corners: .concentric()))
        .containerShape(.rect(cornerRadius: Guidelines.cornerRadius))
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
