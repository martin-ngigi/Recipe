//
//  MyCustomTab.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import SwiftUI

struct MyCustomTab: View {
    let image: String, title: String, isSelected: Bool, bgColor: Color

    var body: some View {
        VStack {

            Image(systemName: image)
                .resizable()
                .frame(width: 43, height: 43)
                .padding(9)
                .background(isSelected ? Color.theme.primaryColor : Color.gray)
                .foregroundColor(isSelected ? Color.theme.blackAndWhite : Color.theme.whiteAndBlack)
                .cornerRadius(8)
        }
    }
}
