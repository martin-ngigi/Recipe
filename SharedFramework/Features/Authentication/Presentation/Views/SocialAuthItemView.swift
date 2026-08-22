/*
* Created by Martin Wainaina on 22/08/2026
*
* Feel free to contribute.
*/

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
        Button {
            onTap()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(16)
        }
        .buttonBorderShape(.roundedRectangle)
        //.glassEffect(.regular.interactive(), in: .rect(cornerRadius: 24))
        .glassEffect(.regular.interactive())

    }
}

#Preview {
    SocialAuthItemView(image: "", onTap: {})
}
