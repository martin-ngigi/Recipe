//
//  ShareSheetView.swift
//  Recipe
//
//  Created by Hummingbird on 01/08/2025.
//

import Foundation
import UIKit
import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
