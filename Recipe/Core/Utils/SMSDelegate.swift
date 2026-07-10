//
//  SMSDelegate.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import Foundation
import MessageUI
import SwiftUI
import UIKit
import os

class SMSDelegate: NSObject, MFMessageComposeViewControllerDelegate {
    let onSuccess: () -> Void
    let onFailure: (String) -> Void

    init(onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }

    func messageComposeViewController(
        _ controller: MFMessageComposeViewController,
        didFinishWith result: MessageComposeResult
    ) {
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

    deinit {}
}
