/*
* Created by Martin Wainaina on 01/08/2026
*
* Feel free to contribute.
*/

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

    private let cornerRadius = Guidelines.cornerRadius

    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            VStack(spacing: 0) {
                if let title {
                    Text(title)
                        .font(.appTitle2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                }

                CustomImageView(
                    url: image,
                    width: .infinity,
                    height: imageHeight
                )
                .frame(maxWidth: .infinity)
                .frame(height: imageHeight)
                .clipped()
                .mask {
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                }

                if let description {
                    Text(description)
                        .font(.appBody)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .padding()
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.94)
            .background(Color.theme.whiteAndBlack)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
                .stroke(
                    Color.theme.primaryColor,
                    lineWidth: 1
                )
            }
            .shadow(radius: 8)
            .padding()
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
