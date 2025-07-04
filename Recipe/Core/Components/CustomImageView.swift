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
                     //.font(.largeTitle)
                     .resizable()
                     .scaledToFill()
             case .success(let image):
                 image
                     .resizable()
                     .scaledToFill()
             default:
                 ProgressView()
             }
         }
         .frame(maxWidth: maxWidth)
         .frame( height: height)
         //.clipShape(.rect(cornerRadius: 25))
     }
}

#Preview {
    CustomImageView(url: "https://hws.dev/paul3.jpg")
}
