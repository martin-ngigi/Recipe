/*
* Created by Martin Wainaina on 06/09/2026
*
* Feel free to contribute.
*/

//
//  PopularChefRow.swift
//  Recipe
//
//  Created by RAFIKI on 12/05/2026.
//

import SwiftUI

struct PopularChefRow: View {
    var chef: UserModel
    var onTap: (UserModel) -> Void

    var body: some View {
        Button {
            onTap(chef)
        } label: {
            HStack (spacing: 8){

                var avatar: String {
                    if chef.avatar.starts(with: "http") {
                        return chef.avatar
                    }
                    else {
                        return "\(Constants.BASE_URL)\(chef.avatar)"
                    }
                }

                CustomImageView(
                    url: avatar,
                    maxWidth: 100,
                    height: 100
                )
                .clipShape(.rect(cornerRadius: 24))

                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(chef.name)
                        .font(.headline)
                    
                    let recipesList = chef.recipesList?.compactMap{$0.name}.joined(separator: ", ") ??  ""
                    
                    Text("\(recipesList)")
                        .lineLimit(3)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                    
                    Text("\(Image(systemName: "star.fill")) \(chef.rate?.ratingFormatted ?? "0.0")")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    /*
                    Image(systemName: "chevron.forward")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 8)
                    */
                }
                .padding(8)
                .foregroundStyle(Color.theme.blackAndWhite)
                
                Spacer()
            }
        }

    }
}

#Preview {
    if let chef = HomeResponseModel.sampleData?.data.popularChefs[0] {
        PopularChefRow(
            chef: chef,
            onTap: { _ in

            }
        )
        .padding()
    }

}
