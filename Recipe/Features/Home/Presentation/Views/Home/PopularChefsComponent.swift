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
        VStack(spacing: 5){
            HStack{
                Text("Popular Chefs")
                    .font(.custom(FontConstants.POPPINS_MEDIUM, size: 22))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button{
                    onTapSeeAll()
                } label: {
                    HStack{
                        Text("See All (\(chefs.count))")
                            .font(.custom(FontConstants.POPPINS_MEDIUM, size: 14))
                            .underline(true, color: Color.theme.primaryColor)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.theme.grayColor1)
                    }
                    .foregroundColor(Color.theme.primaryColor)
                    
                }
            }
            
            VStack{
                if chefs.isEmpty  && isLoading == false {
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

struct PopularChefRow: View {
    var chef: UserModel
    var onTap: (UserModel) -> Void
    
    var body: some View {
        Button{
            onTap(chef)
        } label: {
            HStack {
                CustomImageView(
                    url: chef.avatar,
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
    PopularChefsComponent(
        chefs: HomeResponseModel.sampleData?.data.popularChefs ?? [],
        onTapChef: { chef in
            
        },
        onTapSeeAll: {
            
        }
    )
    .padding()
}
