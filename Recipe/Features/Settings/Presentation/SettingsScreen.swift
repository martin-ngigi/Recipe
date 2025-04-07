//
//  SettingsScreen.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @State var isDarkMode = false
    @State var isNotificationsEnabled = false

    var body: some View {
        VStack{
            VStack{
                
                Image("settings_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text("Customize your settings")
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
            }
            .padding(.top)
            
            
            List {
                Section ("App Settings"){
                    
                    HStack{
                        Text("\(isDarkMode ? "Dark" : "Light") Mode")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                        
                        Spacer()
                        
                        CustomSwitch(
                            isOn: $isDarkMode,
                            onTap: { isOn in
                                isDarkMode = isOn
                            }
                        )
                    }
                    
                    HStack{
                        Text("Notifications turned \(isNotificationsEnabled ? "On" : "Off")")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                        
                        Spacer()
                        
                        CustomSwitch(
                            isOn: $isNotificationsEnabled,
                            onTap: { isOn in
                                isNotificationsEnabled = isOn
                            }
                        )
                    }
                    
                    HStack{
                        Text("Font")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            HStack{
                                Text("\(themesViewModel.selectedFontPrefix)")
                                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                                    .foregroundColor(Color.theme.blackAndWhite)
                                
                                Image(systemName: "chevron.right")
                            }
                        }
                       
                    }
                    
                   
                }
                
                Section ("App Details"){
                    
                    HStack{
                        Text("App Version")
                        
                        Spacer()
                        
                        Text("\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0") ")
                    }
                    .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                    
                    
                    HStack{
                        Text("Privacy policy")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    HStack{
                        Text("FAQs")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    HStack{
                        Text("Feedback and ratings")
                            .font(.custom("\(themesViewModel.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "star")
                        }
                    }
                    
                   
                }

            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsScreen()
        .environmentObject(ThemesViewModel())
}
