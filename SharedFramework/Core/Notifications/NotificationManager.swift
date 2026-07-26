/*
* Created by Martin Wainaina on 26/07/2026
*
* Feel free to contribute.
*/

//
//  NotificationManager.swift
//  Recipe
//
//  Created by RAFIKI on 26/07/2026.
//

import Foundation
import UserNotifications
import Combine
import os


/// Add permission declaration in Info >  NSUserNotificationsUsageDescription
final class NotificationManager: NSObject, ObservableObject{
    static let shared = NotificationManager()
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ){ granted, error in
            
            if let error = error{
                os.Logger().log("DEBUG: requestNotificationPermission failed with error: \(error)")
            }
            else {
                os.Logger().log("DEBUG: requestNotificationPermission granted ? \(granted)")
            }
        }
    }
    
    func showNotification(
        title: String,
        body: String
    ){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) {error in
            if let error = error{
                os.Logger().log("DEBUG: showNotification failed with error \(error)")
            }
        }
    }
    
}

extension NotificationManager: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("Notification tapped")
        completionHandler()
    }
    
}
