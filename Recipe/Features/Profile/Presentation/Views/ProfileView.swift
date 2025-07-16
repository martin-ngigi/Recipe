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
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var favouriteRecipesViewModel = FavouriteRecipesViewModel()
    @State var user: UserModel? = nil
    var onLogoutSuccess: () -> Void
    var onLogoutFailed: (String) -> Void
    
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
                
                Section("Account") {
                    Button{
                        profileViewModel.updateIsShowAlertDialog(value: true)
                        profileViewModel.updateDialogEntity(
                            value:  DialogEntity(
                                title: "Logout",
                                message: "Are you sure you want to logout?",
                                icon: "",
                                confirmButtonText: "Logout",
                                dismissButtonText: "Cancel",
                                onConfirm: {
                                    profileViewModel.updateIsShowAlertDialog(value: false)
                                    loginViewModel.logOut(
                                        onSuccess: {
                                            onLogoutSuccess()
                                            favouriteRecipesViewModel.deleteAllFavourites()
                                        },
                                        onFailure: { error in
                                            onLogoutFailed(error)
                                        }
                                    )
                                },
                                onDismiss: {
                                    profileViewModel.updateIsShowAlertDialog(value: false)
                                }
                            )
                        )
                    } label: {
                        HStack{
                            Text("Logout:")
                                .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                            Spacer()
                            
                            Image(systemName: "power")
                        }
                        .foregroundColor(Color.gray)
                    }
                    
                    Button{
                        profileViewModel.updateIsShowAlertDialog(value: true)
                        profileViewModel.updateDialogEntity(
                            value:  DialogEntity(
                                title: "Delete Account",
                                message: "Please note that this action cannot be undone and deleted data can't be restored.",
                                icon: "",
                                confirmButtonText: "Delete",
                                dismissButtonText: "Cancel",
                                onConfirm: {
                                    Task {
                                        profileViewModel.updateIsShowAlertDialog(value: false)
                                        await loginViewModel.deleteAccount(
                                            onSuccess: {
                                                onLogoutSuccess()
                                            },
                                            onFailure: { error in
                                                onLogoutFailed(error)
                                            }
                                        )
                                    }
                                },
                                onDismiss: {
                                    profileViewModel.updateIsShowAlertDialog(value: false)
                                }
                            )
                        )
                    } label: {
                        HStack{
                            Text("Delete Account:")
                                .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 14))
                            Spacer()
                            
                            Image(systemName: "power.circle.fill")
                        }
                        .foregroundColor(Color.red)
                    }
                }
                
            }
        }
        .onAppear{
            user = loginViewModel.fetchUserFromLocalStorage()
        }
        .overlay {
            CustomAlertDialog(
                isPresented: $profileViewModel.isShowAlertDialog,
                title: profileViewModel.dialogEntity.title,
                text: profileViewModel.dialogEntity.message,
                confirmButtonText: profileViewModel.dialogEntity.confirmButtonText,
                dismissButtonText: profileViewModel.dialogEntity.dismissButtonText,
                imageName: profileViewModel.dialogEntity.icon,
                onDismiss: {
                    if let onDismiss = profileViewModel.dialogEntity.onDismiss {
                        onDismiss()
                    }
                },
                onConfirmation: {
                    if let onConfirm = profileViewModel.dialogEntity.onConfirm {
                        onConfirm()
                    }
                }
            )
        }
        //.hideBottomNavigationBar(false)
    }
}

#Preview {
    ProfileView(
        onLogoutSuccess: {
            
        },
        onLogoutFailed: { error in
            
        }
    )
}
