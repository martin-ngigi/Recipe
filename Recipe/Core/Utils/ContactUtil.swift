//
//  ContactUtil.swift
//  Recipe
//
//  Created by Hummingbird on 01/08/2025.
//

import Foundation
import SwiftUI

import MessageUI
import UIKit

class ContactUtil{
    static var shared = ContactUtil()
    
    func openWhatsApp(
        phoneNumber: String,
        message: String,
        onSuccess: () -> Void,
        onFailure: (String) -> Void
    ) {
        let urlString = "https://wa.me/\(phoneNumber)?text=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            onSuccess()
        }
        else {
            print("DEBUG: WhatsApp is not installed or URL is invalid.")
            onFailure("Could not open Whatsapp")
        }
        
        //MARK: Remember to ass this to your Info.plist to allow your app to open external URLs:
        /*
         <key>LSApplicationQueriesSchemes</key>
         <array>
             <string>whatsapp</string>
         </array>

         */
    }
    
    
    func openSMS(
        phoneNumber: String,
        message: String,
        onSuccess: @escaping () -> Void,
        onFailure: @escaping (String) -> Void
    ) {
        guard MFMessageComposeViewController.canSendText() else {
            onFailure("SMS services are not available on this device.")
            return
        }
        
        let messageVC = MFMessageComposeViewController()
        messageVC.recipients = [phoneNumber]
        messageVC.body = message
        messageVC.messageComposeDelegate = SMSDelegate(onSuccess: onSuccess, onFailure: onFailure)
        
        // To present the messageVC, you need a UIViewController,
        // for example, the root view controller or current view controller.
        // Assuming a UIKit environment:
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(messageVC, animated: true, completion: nil)
        }
        else {
            //onFailure("Unable to find a root view controller to present SMS composer.")
            onFailure("Unable to find SMS composer.")
        }
    }
    
    func openCallDailer(
        phoneNumber: String,
        onSuccess: () -> Void,
        onFailure: (String) -> Void
    ) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
        else {
            onFailure("Unable to open the dialer.")
        }
    }
}


//MARK: A helper class to handle MFMessageComposeViewControllerDelegate callbacks
class SMSDelegate: NSObject, MFMessageComposeViewControllerDelegate {
    let onSuccess: () -> Void
    let onFailure: (String) -> Void

    init(onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true) {
            switch result {
            case .sent:
                self.onSuccess()
            case .failed:
                self.onFailure("Failed to send the message.")
            case .cancelled:
                self.onFailure("User cancelled the message.")
            @unknown default:
                self.onFailure("Unknown result.")
            }
        }
    }
}
