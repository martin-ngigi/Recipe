//
//  JustForYouSliderView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct JustForYouSliderView: View {
    var recipes: [RecipeModel]
    var onTap: (RecipeModel) -> Void
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 5) {
            Text("Just For You")
                .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TabView(selection: $currentIndex) {
                ForEach(0..<recipes.count, id: \.self) { index in
                    ZStack {
                        Button {
                            onTap(recipes[index])
                        } label: {
                            CustomImageView(
                                url: recipes[index].image,
                                maxWidth: .infinity,
                                height: 150
                            )
                            .foregroundColor(Color.theme.blackAndWhite)
                            .clipped()
                            .cornerRadius(10)
                            .contentShape(Rectangle())
                            .overlay {
                                ZStack {
                                    Color.black.opacity(0.4)
                                        .cornerRadius(10)
                                    
                                    VStack {
                                        Spacer()
                                        Text("\(recipes[index].name) by \(recipes[index].chef?.name ?? "")")
                                            .font(.custom(FontConstants.POPPINS_LIGHT, size: 18))
                                            .foregroundColor(Color.theme.whiteColor)
                                            .padding(.bottom, 8)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        
                    }
                    .tag(index)
                }
            }
            .frame(height: 150)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onReceive(timer) { _ in
                withAnimation {
                    if recipes.count > 0{
                        currentIndex = (currentIndex + 1) % recipes.count
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
        onTap: { recipe in
            
        }
    )
    .padding()
}
