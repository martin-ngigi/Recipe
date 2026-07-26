//
//  EmptyScreenView.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import Foundation
import SwiftUI

struct EmptyScreenView: View {
    let imageName: String
    var imageSize: CGFloat = 90

    let title: String
    var titleSize: CGFloat = 26

    let description: String
    var descriptionSize: CGFloat = 15

    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 24) {

                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.blue.opacity(0.15),
                                    Color.theme.primaryColor.opacity(0.08)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 150, height: 150)

                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, Color.theme.primaryColor],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }

                VStack(spacing: 12) {

                    Text(title)
                        .font(.system(size: titleSize, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)

                    Text(description)
                        .font(.system(size: descriptionSize))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 20)
                }

                if let actionTitle, let action {
                    Button(action: action) {
                        Text(actionTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 14)
                            .background(
                                LinearGradient(
                                    colors: [.blue, Color.theme.primaryColor],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(Capsule())
                            .shadow(color: .blue.opacity(0.25), radius: 10, y: 6)
                    }
                    .frame(minHeight: 44)
                    .padding(.top, 8)
                }
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(
                        color: Color.black.opacity(0.06),
                        radius: 20,
                        x: 0,
                        y: 10
                    )
            )

            Spacer()
        }
    }
}

#Preview {
    EmptyScreenView(
        imageName: "tray",
        title: "No Items Found",
        description: "There are no items to display here yet. Please come back later!"
    )
}
