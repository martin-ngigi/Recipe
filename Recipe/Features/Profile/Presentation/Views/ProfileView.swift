//
//  ProfileView.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    var name = "John Doe"
    
    var initials: String {
            let components = name.split(separator: " ")
            let firstInitial = components.first?.prefix(1) ?? ""
            let secondInitial = (components.count > 1 ? components[1].prefix(1) : "")
            return "\(firstInitial)\(secondInitial)".uppercased()
        }

    var body: some View {
        VStack{
            Text(initials)
                .font(.custom("\(themesViewModel.selectedFontPrefix)-Medium", size: 70))
                .frame(width: 100, height: 100)
                .foregroundColor(.primary)
                .padding(20)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(100)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
            /*
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, alignment: .center)
            */
            
            List {
               
                
                Section("Personal Details") {
                    HStack{
                        Text("Name:")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                        Spacer()
                        
                        Text("John Doe")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                    }
                    
                    HStack{
                        Text("Email:")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                        Spacer()
                        
                        Text("john@gmail.com")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 14))
                    }
                }
                
            }
        }
        
    }
}

#Preview {
    ProfileView()
        .environmentObject(ThemesViewModel())
}
