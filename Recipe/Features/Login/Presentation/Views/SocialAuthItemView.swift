//
//  SocialAuthItemView.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct SocialAuthItemView: View {
    let image: String
    var onTap: () -> Void
    
    var body: some View {
        Button{
            onTap()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(10) // Add padding for better spacing
                .background(Color.gray.opacity(0.2)) // Light gray background
                .clipShape(RoundedRectangle(cornerRadius: 6)) // Ensures the background follows the shape
               .overlay(
                   RoundedRectangle(cornerRadius: 6)
                       .stroke(Color.gray, lineWidth: 1) // Gray border
               )
        }
        
    }
}

#Preview {
    SocialAuthItemView(image: "", onTap: {})
}
