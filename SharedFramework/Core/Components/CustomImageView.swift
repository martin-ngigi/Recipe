/*
* Created by Martin Wainaina on 06/09/2026
*
* Feel free to contribute.
*/

//
//  CustomImageView.swift
//  Recipe
//
//  Created by Hummingbird on 03/07/2025.
//

import SwiftUI

struct CustomImageView: View {
    let url: String
    var maxWidth: CGFloat = .infinity
    var height: CGFloat = 256

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.gray)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                ProgressView()
            }
        }
        .frame(maxWidth: maxWidth, maxHeight: height)
        .clipped()
    }
}

#Preview {
    CustomImageView(url: "https://images.immediate.co.uk/production/volatile/sites/30/2022/06/Party-food-recipes-fcfb3af.jpg?resize=1366,1503")
}
