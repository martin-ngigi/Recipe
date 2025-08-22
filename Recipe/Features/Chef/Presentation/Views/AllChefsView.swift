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

    var body: some View {
        VStack {
            List {
                if list.isEmpty{
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
                            PopularChefRow(
                                chef: chef,
                                onTap: { chef in
                                    router.push(.chefdetails(chef: chef))
                                }
                            )
                            
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("All Chefs")
            //.hideBottomNavigationBar(false)
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
