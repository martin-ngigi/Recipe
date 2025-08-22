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
    var imageSize: CGFloat = 120
    let title: String
    var titleSize: CGFloat = 24
    let description: String
    var descriptionSize: CGFloat = 12
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(.gray)
                .padding(.bottom, 8)

            Text(title)
                .font(.system(size: titleSize, weight: .bold, design: .default))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(description)
                .font(.system(size: descriptionSize, weight: .light, design: .default))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground)) 
    }
}

#Preview {
    EmptyScreenView(
        imageName: "tray",
        title: "No Items Found",
        description: "There are no items to display here yet. Please come back later!"
    )
}
