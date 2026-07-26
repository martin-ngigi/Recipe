//
//  PopularChefsComponent.swift
//  Recipe
//
//  Created by Hummingbird on 08/07/2025.
//

import SwiftUI

struct PopularChefsComponent: View {

    var chefs: [UserModel]
    var isLoading: Bool = false
    var onTapChef: (UserModel) -> Void
    var onTapSeeAll: () -> Void

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Popular Chefs")
                    .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button {
                    onTapSeeAll()
                } label: {
                    HStack {
                        Text("See All (\(chefs.count))")
                            .font(.custom(FontConstants.POPPINS_MEDIUM, size: 14))
                            .underline(true, color: Color.theme.primaryColor)

                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.theme.grayColor1)
                    }
                    .foregroundColor(Color.theme.primaryColor)

                }
            }

            VStack {
                if chefs.isEmpty && isLoading == false {
                    EmptyScreenView(
                        imageName: "tray",
                        imageSize: 80,
                        title: "Chefs",
                        titleSize: 18,
                        description: """
                            No Popular Chefs recipes found.
                            """,
                        descriptionSize: 12
                    )
                }
                else {
                    ForEach(chefs, id: \.self) { chef in
                        PopularChefRow(
                            chef: chef,
                            onTap: { chef in
                                onTapChef(chef)
                            }
                        )
                    }
                }

            }
        }
        .padding(.bottom, 50)
    }
}

#Preview {
    PopularChefsComponent(
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? [],
        onTapChef: { _ in

        },
        onTapSeeAll: {

        }
    )
    .padding()
}
