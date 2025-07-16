//
//  PopularChefsComponent.swift
//  Recipe
//
//  Created by Hummingbird on 08/07/2025.
//

import SwiftUI

struct PopularChefsComponent: View {
//    var columns: [GridItem] =  [ GridItem(.flexible()), GridItem(.flexible())]
    var columns: [GridItem] {
        let fullWidth = UIScreen.main.bounds.width
        let columnWidth: CGFloat = UIScreen.main.bounds.width // desired width for each column
        let fullWidthLessPadding = fullWidth - (10 * 2) // subtracting padding on both sides
        let countDouble: Double = fullWidthLessPadding / columnWidth
        let countFloor = floor(countDouble)
        let count = max(Int(countFloor), 1) // ensuring there's at least one column
        
        return Array(repeating: GridItem(.fixed(columnWidth), spacing: 10, alignment: .center), count: count)
    }
    var chefs: [UserModel]
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
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
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
