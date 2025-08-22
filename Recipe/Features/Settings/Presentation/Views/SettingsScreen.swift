//
//  SettingsScreen.swift
//  Recipe
//
//  Created by Martin on 04/04/2025.
//

import SwiftUI

struct SettingsScreen: View {
    //@AppStorage(Keys.theme.rawValue) private var theme: AppTheme = .system
    @StateObject var themesViewModel = ThemesViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    
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
                    Picker("Theme", selection: $theme) {
                        Text("System").tag(AppTheme.system)
                        Text("Light").tag(AppTheme.light)
                        Text("Dark").tag(AppTheme.dark)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    */
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("Theme")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        
                        Picker("Theme", selection: $themesViewModel.currentTheme) {
                            ForEach(ThemeEntity.allCases) { theme in
                                Text(theme.themName)
                                    .tag(theme)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: themesViewModel.currentTheme) { newValue in
                            themesViewModel.changeTheme(to: newValue)
                        }
                    }
                    
                    HStack{
                        Text("Notifications turned \(settingsViewModel.isNotificationsEnabled ? "On" : "Off")")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        
                        Spacer()
                        
                        CustomSwitch(
                            isOn: $settingsViewModel.isNotificationsEnabled,
                            onTap: { isOn in
                                settingsViewModel.updateIsNotificationsEnabled(value: isOn)
                                settingsViewModel.updateToast(
                                    value: Toast(
                                        style: .success,
                                        message: "Notifications \(isOn ? "On" : "Off")"
                                    )
                                )
                            }
                        )
                    }
                    
                    HStack{
                        Text("Font")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            settingsViewModel.updateToast(
                                value: Toast(
                                    style: .success,
                                    message: "Fonts coming soon!"
                                )
                            )
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
                            settingsViewModel.updateToast(
                                value: Toast(
                                    style: .success,
                                    message: "FAQs coming soon!"
                                )
                            )
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    HStack{
                        Text("Feedback and ratings")
                            .font(.custom("\(LocalState.selectedFontPrefix)-Light", size: 17))
                        Spacer()
                        
                        Button{
                            settingsViewModel.updateToast(
                                value: Toast(
                                    style: .success,
                                    message: "Feedback and ratings coming soon!"
                                )
                            )
                        } label: {
                            Image(systemName: "star")
                        }
                    }
                    
                   
                }

            }
        }
        .navigationTitle("Settings")
        .toastView(toast: $settingsViewModel.toast)
        //.hideBottomNavigationBar(false)
    }
}

#Preview {
    SettingsScreen()
}
