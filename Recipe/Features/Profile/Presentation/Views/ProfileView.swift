//
//  ProfileView.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct ProfileView: View {
    var name = "John Doe"
    @StateObject var loginViewModel = LoginViewModel()
    @State var user: UserModel? = nil
    
    var initials: String {
            let components = "\(user?.name ?? "")".split(separator: " ")
            let firstInitial = components.first?.prefix(1) ?? ""
            let secondInitial = (components.count > 1 ? components[1].prefix(1) : "")
            return "\(firstInitial)\(secondInitial)".uppercased()
        }

    var body: some View {
        VStack{
            Text(initials)
                .font(.custom("\(LocalState.selectedFontPrefix)-Medium", size: 70))
                .frame(width: 100, height: 100)
                .foregroundColor(.primary)
                .padding(20)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(100)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
            
            List {
               
                
                Section("Personal Details") {
                    HStack{
                        Text("Name:")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                        Spacer()
                        
                        Text(user?.name ?? "")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                    }
                    
                    HStack{
                        Text("Email:")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                        Spacer()
                        
                        Text(user?.email ?? "")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                    }
                    
                    HStack{
                        Text("Phone:")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                        Spacer()
                        
                        Text(user?.phoneComplete ?? "")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                    }
                }
                
            }
        }
        .onAppear{
            user = loginViewModel.fetchUserFromLocalStorage()
        }
        //.hideBottomNavigationBar(false)
    }
}

#Preview {
    ProfileView()
}
