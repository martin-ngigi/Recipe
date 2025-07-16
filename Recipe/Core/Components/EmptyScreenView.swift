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
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: imageName)          // or use Image(imageName) for asset images
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.gray)
                .padding(.bottom, 8)

            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
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
