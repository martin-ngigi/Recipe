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
                .foregroundStyle(Color.theme.primaryTextColor)
                .font(.title2.bold())
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
                                            recipes: recipes,
                                            recipe: recipes[index],
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
                                            recipes: recipes,
                                            recipe: recipes[index],
                                        )
                                    }
                                }
                                .tag(index)
                            }
                        }
                        .frame(height: 240)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .overlay(alignment: .bottom) {
                            DotsView(count: recipes.count, currentIndex: currentIndex)
                                .padding(.vertical, 8) //8+8+8
                        }
                        .glassEffectCustomRectangular()
                        .clipShape(RoundedRectangle(cornerRadius: Guidelines.cornerRadius))
                        .onReceive(timer) { _ in
                            guard !reduceMotion else { return }
                            withAnimation {
                                if !recipes.isEmpty {
                                    onUpdateCurrentIndex((currentIndex + 1) % recipes.count)
                                }
                            }
                        }
                        .padding(.horizontal, Guidelines.horizontalPadding)

                    }
                }
            }
        }
        .padding(.top, 10)
    }
}

struct JustForYouSliderItem: View {
    var recipes: [RecipeModel]
    var recipe: RecipeModel
    
    var body: some View{
        CustomImageView(
            url: recipe.image,
            width: .infinity,
            height: 240
        )
        .foregroundColor(Color.theme.blackAndWhite)
        .clipped()
        .contentShape(Rectangle())
        .overlay(alignment: .bottom) {
            VStack(spacing: 2){
                Text(recipe.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text(recipe.chef?.name ?? "")
                    .font(.footnote)
                    .foregroundColor(Color.theme.secondaryTextColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 24) // //8+8+8+8
            .padding(.top, 8)
            .padding(.horizontal)
            .background(
                LinearGradient(
                    colors: [
                        Color(.systemBackground).opacity(0.95),
                        Color(.systemBackground).opacity(0.95),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .clipShape(.rect(corners: .concentric()))
        //.containerShape(.rect(cornerRadius: Guidelines.cornerRadius))
        .clipShape(
               .rect(
                   topLeadingCorner: 0,
                   topTrailingCorner: 0,
                   bottomLeadingCorner: .concentric(minimum: 24),
                   bottomTrailingCorner: .concentric(minimum: 24)
               )
           )
    }
}

struct DotsView: View {

    let count: Int
    let currentIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .fill(
                        index == currentIndex
                            ? Color.theme.primaryTextColor
                            : Color.gray.opacity(0.4)
                    )
                    .frame(
                        width: index == currentIndex ? 16 : 8,
                        height: 8
                    )
                    .animation(.easeInOut(duration: 0.25), value: currentIndex)
            }
        }
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
}
