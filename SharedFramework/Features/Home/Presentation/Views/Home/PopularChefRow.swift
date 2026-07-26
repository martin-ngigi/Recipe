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
            HStack {

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
                    maxWidth: 60,
                    height: 60
                )
                .clipShape(.rect(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 8) {
                    Text(chef.name)
                        .font(.headline)

                    Text("⭐️ \(chef.rate?.ratingFormatted ?? "0.0")")
                        .font(.body)
                        .foregroundColor(.orange)
                }
                .foregroundStyle(Color.theme.blackAndWhite)

                Spacer()
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }

    }
}

#Preview {
    if let chef = UserModel.dummyChefResoinse?.data {
        PopularChefRow(
            chef: chef,
            onTap: { _ in

            }
        )
    }

}
