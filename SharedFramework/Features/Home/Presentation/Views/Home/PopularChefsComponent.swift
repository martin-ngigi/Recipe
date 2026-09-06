/*
* Created by Martin Wainaina on 24/08/2026
*
* Feel free to contribute.
*/

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
    var isEmpty: Bool {
        return chefs.isEmpty && isLoading == false
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            HStack {
                Text("Popular Chefs")
                    .font(.headline)

                Spacer()

                if !isEmpty {
                    Button {
                        onTapSeeAll()
                    } label: {
                        HStack(spacing: 4) {
                            Text("See All")
                                .font(.footnote)

                            Image(systemName: "chevron.right")
                                .imageScale(.small)

                        }
                        .foregroundStyle(.primary)
                    }
                }

            }

            VStack(alignment: .leading, spacing: 16){
                if isEmpty {
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
                        .glassEffectCustomRectangular()
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
