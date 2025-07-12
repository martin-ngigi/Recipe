//
//  ShareRecipeUtil.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation

import UIKit
import SwiftUI

struct ShareRecipeUtil {
    static let shared = ShareRecipeUtil()
    
    // MARK: - Share Recipe as PDF
     
    func shareRecipeAsPDF(
        recipe: RecipeModel,
        onSuccess: () -> Void,
        onError: (String) -> Void
        //isLoading: Binding<Bool>? = nil
    ) async {
        
        let image = await downloadImage(
            from: recipe.image,
            onSuccess: {
                //onSuccess()
            },
            onError: { error in
                onError(error)
            }
        )
        
         if let pdfURL = createRecipePDF(recipe: recipe, image: image) {
             DispatchQueue.main.async {
                 sharePDF(url: pdfURL)
             }
             onSuccess()
         } else {
             print("Failed to create PDF")
             onError("Failed to create PDF")
         }
     }
    
    func downloadImage(
        from urlString: String,
        onSuccess: () -> Void,
        onError: (String) -> Void
    ) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
            onSuccess()
        } catch {
            print("Image download failed: \(error)")
            onError(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - Create PDF
    
    func createRecipePDF(recipe: RecipeModel, image: UIImage?) -> URL? {
        let pdfPageWidth: CGFloat = 595.2  // A4 width
        let pdfPageHeight: CGFloat = 841.8 // A4 height
        let pageRect = CGRect(x: 0, y: 0, width: pdfPageWidth, height: pdfPageHeight)
        
        let pdfMetaData = [
            kCGPDFContextCreator: "RecipeApp",
            kCGPDFContextAuthor: "YourName"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let tempDir = FileManager.default.temporaryDirectory
        let pdfURL = tempDir.appendingPathComponent("\(recipe.name).pdf")
        
        do {
            try renderer.writePDF(to: pdfURL, withActions: { context in
                context.beginPage()
                
                // Draw Title
                let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
                let titleAttributes: [NSAttributedString.Key: Any] = [.font: titleFont]
                let titleString = NSAttributedString(string: recipe.name, attributes: titleAttributes)
                let titleStringSize = titleString.size()
                let titleRect = CGRect(x: 20, y: 20, width: pageRect.width - 40, height: titleStringSize.height)
                titleString.draw(in: titleRect)
                
                // Draw Image
                if let uiImage = image {
                    let maxImageWidth = pageRect.width - 40
                    let aspectRatio = uiImage.size.width / uiImage.size.height
                    let imageWidth = maxImageWidth
                    let imageHeight = imageWidth / aspectRatio
                    
                    let imageRect = CGRect(x: 20, y: titleRect.maxY + 20, width: imageWidth, height: imageHeight)
                    uiImage.draw(in: imageRect)
                    
                    // Draw Description below image
                    let descriptionFont = UIFont.systemFont(ofSize: 16)
                    let descriptionAttributes: [NSAttributedString.Key: Any] = [.font: descriptionFont]
                    let descriptionString = NSAttributedString(string: recipe.description, attributes: descriptionAttributes)
                    
                    let descriptionRect = CGRect(x: 20, y: imageRect.maxY + 20, width: pageRect.width - 40, height: pageRect.height - imageRect.maxY - 40)
                    descriptionString.draw(in: descriptionRect)
                } else {
                    // No image: draw description below title
                    let descriptionFont = UIFont.systemFont(ofSize: 16)
                    let descriptionAttributes: [NSAttributedString.Key: Any] = [.font: descriptionFont]
                    let descriptionString = NSAttributedString(string: recipe.description, attributes: descriptionAttributes)
                    
                    let descriptionRect = CGRect(x: 20, y: titleRect.maxY + 20, width: pageRect.width - 40, height: pageRect.height - titleRect.maxY - 40)
                    descriptionString.draw(in: descriptionRect)
                }
            })
            
            return pdfURL
        } catch {
            print("Could not create PDF: \(error)")
            return nil
        }
    }
    
    // MARK: - Present Share Sheet
    
    func sharePDF(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}


