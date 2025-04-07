//
//  JustForYouSliderView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct JustForYouSliderView: View {
    let sliderItems = [
        ("landing", "15 best pasta recipes from Chef John"),
        ("landing", "Quick snacks for a busy day"),
        ("landing", "Healthy breakfast ideas")
    ]
    
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 5) {
            Text("Just For You")
                .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TabView(selection: $currentIndex) {
                ForEach(0..<sliderItems.count, id: \.self) { index in
                    ZStack {
                        Image(sliderItems[index].0)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)
                            .contentShape(Rectangle())
                            .overlay {
                                ZStack {
                                    Color.black.opacity(0.4)
                                        .cornerRadius(10)
                                    
                                    VStack {
                                        Spacer()
                                        Text(sliderItems[index].1)
                                            .font(.custom(FontConstants.POPPINS_LIGHT, size: 18))
                                            .foregroundColor(Color.theme.whiteColor)
                                            .padding(.bottom, 8)
                                            .padding(.horizontal)
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
                    currentIndex = (currentIndex + 1) % sliderItems.count
                }
            }
        }
        .padding(.top, 10)
    }
}


#Preview {
    JustForYouSliderView()
}
