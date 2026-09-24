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
    var namespace: Namespace.ID
    var onTapSeeAll: () -> Void
    var isEmpty: Bool {
        return chefs.isEmpty && isLoading == false
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            HStack {
                Text("Popular Chefs")
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .font(.title2.bold())

                Spacer()

                if !isEmpty {
                    HStack(spacing: 4) {
                        Text("See All")
                            .font(.footnote)

                        Image(systemName: "chevron.right")
                            .imageScale(.small)

                    }
                    .foregroundStyle(Color.theme.primaryColor)
                    .accessibilityLabel("See all popular chefs")
                    .tappableArea(onTap: onTapSeeAll)
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
                        
                        NavigationLink {
                            ChefDetailsView(chef: chef)
                                .navigationTransition(.zoom(sourceID: chef.openID, in: namespace))
                        } label: {
                            PopularChefRow(chef: chef, namespace: namespace)
                                .background(Color(.secondarySystemGroupedBackground))
                                .clipShape(RoundedRectangle(cornerRadius: Guidelines.cornerRadius))
                                //.glassEffectCustomRectangular()
                        }
                        
                    }
                }

            }
        }
        .padding(.bottom, 50)
    }
}

#Preview {
    PopularChefsComponent(
        chefs: HomeResponseModel.mockData?.data.popularChefs ?? [],
        namespace: Namespace().wrappedValue,
        onTapSeeAll: {

        }
    )
    .padding()
}
