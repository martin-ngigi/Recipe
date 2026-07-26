//
//  ContactUtil.swift
//  Recipe
//
//  Created by Hummingbird on 01/08/2025.
//

import Foundation
import MessageUI
import SwiftUI
import UIKit
import os

class ContactUtil {
    static var shared = ContactUtil()

    func openWhatsApp(
        phoneNumber: String,
        message: String,
        onSuccess: () -> Void,
        onFailure: (String) -> Void
    ) {
        let urlString =
            "https://wa.me/\(phoneNumber)?text=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            onSuccess()
        }
        else {
            os.Logger().debug("DEBUG: WhatsApp is not installed or URL is invalid.")
            onFailure("Could not open Whatsapp")
        }

        // MARK: Remember to ass this to your Info.plist to allow your app to open external URLs:
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
            // onFailure("Unable to find a root view controller to present SMS composer.")
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

    deinit {}
}
