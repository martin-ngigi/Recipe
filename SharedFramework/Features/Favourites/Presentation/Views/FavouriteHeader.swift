/*
* Created by Martin Wainaina on 12/08/2026
*
* Feel free to contribute.
*/

//
//  FavouriteHeader.swift
//  SharedFramework
//
//  Created by RAFIKI on 12/08/2026.
//

import Foundation
import SwiftUI

struct FavouriteHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.appBody)
                .foregroundColor(.primary)
                .padding(.top, 16)
                .padding(.bottom, 4)
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground).opacity(0.9))
        .cornerRadius(4)
    }
}

#Preview {
    FavouriteHeader(title: "Header")
}
