//
//  FavouriteItemView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

struct FavouriteItemView: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @State var isFavourite: Bool = false

    var body: some View {
        HStack{
            Image("pizza")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: 120, height: 100)

            VStack(alignment: .leading){
                
                Button{
                    isFavourite.toggle()
                } label: {
                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(Color.theme.primaryColor)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

                
                Text("Pizza")
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Medium", size: 14))
                    .lineLimit(1)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                
                Spacer()
            }
        }
        .frame(maxHeight: 100)
    }
}

#Preview {
    FavouriteItemView()
        .environmentObject(ThemesViewModel())

}
