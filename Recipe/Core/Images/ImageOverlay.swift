//
//  ImageOverlay.swift
//  Recipe
//
//  Created by Hummingbird on 23/08/2025.
//

import SwiftUI

struct ImageOverlay: View {
    var title: String?
    var image: String
    var imageWidth: Double = .infinity
    var imageHeight: Double = 240
    var description: String?
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    onDismiss()
                }
            
            VStack(spacing: 20) {
                if let title = title {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                }
                
                CustomImageView(
                    url: image,
                    maxWidth: imageWidth,
                    height: imageHeight
                )
                
                if let description = description {
                    Text(description)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
            }
            .background(Color.theme.whiteAndBlack)
            //.cornerRadius(11)
            .clipShape(RoundedRectangle(cornerRadius: 11))
            .frame(maxWidth: UIScreen.main.bounds.width * 0.94)
            .clipped()
            .overlay(
                   RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.theme.primaryColor, lineWidth: 1)
               )
            .padding()
            .shadow(radius: 10)
        }
       
    }
}

#Preview {
    ImageOverlay(
        image: "https://recipe.safiribytes.com/images/profile/chef_avatar.png",
        onDismiss: {
            
        }
    )
}
