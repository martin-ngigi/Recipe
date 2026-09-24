/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  AllChefsView.swift
//  Recipe
//
//  Created by Hummingbird on 16/07/2025.
//

import SwiftUI

struct AllChefsView: View {
    var list: [UserModel]
    @EnvironmentObject var router: Router
    @Namespace var namespace

    var body: some View {
        VStack {
            List {
                if list.isEmpty {
                    EmptyScreenView(
                        imageName: "tray",
                        imageSize: 120,
                        title: "Chefs",
                        titleSize: 24,
                        description: """
                            No Popular Chefs recipes found.
                            """,
                        descriptionSize: 12
                    )
                }
                else {
                    ForEach(list, id: \.self) { chef in
                        VStack(spacing: 10) {
                            Button{
                                router.push(.chefdetails(chef: chef))
                            } label: {
                                PopularChefRow(
                                    chef: chef,
                                    namespace: namespace,
                                )
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("All Chefs")
        }
    }
}

#Preview {
    if let chef: UserModel = UserModel.dummyChefResoinse?.data {
        AllChefsView(
            list: [chef]
        )
        .environmentObject(Router())
    }
    else {
        Text("No Chefs")
    }

}
