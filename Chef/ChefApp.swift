/*
* Created by Martin Wainaina on 26/07/2026
*
* Feel free to contribute.
*/

//
//  ChefApp.swift
//  Chef
//
//  Created by RAFIKI on 26/07/2026.
//

import SwiftUI

@main
struct ChefApp: App {
    
    init() {
        NotificationManager.shared.requestNotificationPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
