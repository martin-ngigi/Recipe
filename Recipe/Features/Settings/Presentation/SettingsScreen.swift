//
//  SettingsScreen.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct SettingsScreen: View {
    @State var isDarkMode = false
    @State var isNotificationsEnabled = false
    @State var theme: AppTheme = LocalState.theme

    var body: some View {
        VStack{
            VStack{
                
                Image("settings_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text("Customize your settings")
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
            }
            .padding(.top)
            
           
            List {
                Section ("App Settings"){
                    
                    /*
                    HStack{
                        Text("\(isDarkMode ? "Dark" : "Light") Mode")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        
                        Spacer()
                        
                        CustomSwitch(
                            isOn: $isDarkMode,
                            onTap: { isOn in
                                isDarkMode = isOn
                            }
                        )
                    }
                    */
                    
                    Picker("App Theme", selection: $theme){
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.rawValue.capitalized).tag(theme)
                        }
                    }
                    .onChange(of: theme) { newValue in
                        LocalState.theme = newValue
                    }
                    
                    HStack{
                        Text("Notifications turned \(isNotificationsEnabled ? "On" : "Off")")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        
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
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            HStack{
                                Text("\(LocalState.selectedFontPrefix)")
                                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
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
                    .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                    
                    
                    HStack{
                        Text("Privacy policy")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    HStack{
                        Text("FAQs")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    HStack{
                        Text("Feedback and ratings")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
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
        .hideBottomNavigationBar(false)
    }
}

#Preview {
    SettingsScreen()
}
